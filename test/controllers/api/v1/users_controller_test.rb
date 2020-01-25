require 'test_helper'

class Api::V1::UsersControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'profile' do
    process :profile, method: :get, headers: api_key_header
    assert_response :ok
    assert_template 'api/v1/users/profile'
    profile_response(json_response)
  end

  private

  def profile_response(json_response)
    [:id, :email, :first_name, :last_name].each do |attr|
      assert json_response.has_key?(attr.to_s), "#{attr} is not present in response"
    end
  end
end
