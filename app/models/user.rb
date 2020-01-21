class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_api_key
    api_key = formulate_key
    debugger
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
  
  private
  
  def formulate_key
    str = OpenSSL::Digest::SHA256.digest("#{SecureRandom.uuid}_#{self.id}_#{Time.now.to_i}")
    Base64.encode64(str).gsub(/[\s=]+/, "").tr('+/','-_')
  end
end
