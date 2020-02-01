class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validations
  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of [ :first_name, :last_name ]

  def generate_api_key
    api_key = formulate_key
    # Write it into cache
    Rails.cache.write(User.cached_api_key(api_key),
      self.id,
      :expires_in => 86400)
    # Return the hash
    api_key
  end
  
  def self.cached_api_key(api_key)
    "api/#{api_key}"
  end


  def self.from_api_key(api_key, renew = false)
    cached_key = self.cached_api_key(api_key)
    id = Rails.cache.read cached_key
    if id
      user = User.find_by_id id
      # Renew the token
      if renew && user
        Rails.cache.write cached_key, id,
          expires_in: 86400
      end
    end
    user
  end

  def self.find_for_database_authentication(conditions)
    email = conditions.delete(:login)
    password = conditions.delete(:password)
    user = User.where(email: email).first
    if user.valid_password?(password)
      user
    else
      raise CagSelfApi::Exception::InvalidParameter.new(_('devise.invalid_user_or_password'))
    end
    user
  end

  def get_user_unattempted_questions(total_question_ids)
    user_attempted_question_ids = self.get_user_attempted_questions(total_question_ids)
    unattempted_question_ids = total_question_ids - user_attempted_question_ids
    unattempted_question_ids
  end

  def get_user_attempted_questions(total_question_ids)
    user_attempted_question_ids = Answer.where(user_id: self.id, is_skipped: false, question_id: total_question_ids).pluck(:question_id)
    user_attempted_question_ids
  end

  def get_user_skipped_questions(total_question_ids)
    user_skipped_question_ids = Answer.where(user_id: self.id, is_skipped: true, question_id: total_question_ids)
    user_skipped_question_ids
  end

  def get_user_correct_questions(total_question_ids)
    user_correct_question_ids = Answer.where(user_id: self.id, question_id: total_question_ids, is_answer_correct: true)
    user_correct_question_ids
  end

  def get_user_incorrect_questions(total_question_ids)
    user_incorrect_question_ids = Answer.where(user_id: self.id, question_id: total_question_ids, is_answer_correct: false)
    user_incorrect_question_ids
  end

  def get_user_questions_details(total_question_ids)
    return self.get_user_attempted_questions(total_question_ids), self.get_user_unattempted_questions(total_question_ids), self.get_user_skipped_questions(total_question_ids)
  end

  private
  
  def formulate_key
    str = OpenSSL::Digest::SHA256.digest("#{SecureRandom.uuid}_#{self.id}_#{Time.now.to_i}")
    Base64.encode64(str).gsub(/[\s=]+/, "").tr('+/','-_')
  end
end
