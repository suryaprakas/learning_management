class UserSessionsController < Devise::SessionsController
  skip_before_action :authenticate_user_token!, :authenticate_user!, only: [:create, :sign_up, :saml_signin]
  skip_before_action :verify_authenticity_token
  swagger_controller :user_sessions, 'Users Sessions'

  swagger_api :sign_up do
    summary 'Sign UP'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[first_name]', :string, :required, 'First name'
    param :form, :'user[last_name]', :string, :required, 'Last name'
    param :form, :'user[password]', :password, :required, 'Password'
  end
  
  def sign_up
    @user = User.new(user_params)
    @user.password = params[:user][:password]
    if @user.save!
      render json: { user_details: @user}, status: :created
    else
      render json: {errors: @user.errors.messages}
    end
  end
  
  swagger_api :create do
    summary 'Sign in a user to the application and returns back authentication token'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[password]', :password, :required, 'Password'
    response :created
    response :unauthorized
  end
  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication({ login: params[:user][:email], password: params[:user][:password] })
    sign_in(resource_name, resource)
    render json: { api_key: resource.generate_api_key }, status: :created
  end

  swagger_api :destroy do
    summary 'Signout a user'
    response :ok
    response :unprocessable_entity
  end
  # DELETE /resource/sign_out
  def destroy
    Rails.cache.delete User.cached_api_key(request.env['HTTP_X_API_KEY'])
    head :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
