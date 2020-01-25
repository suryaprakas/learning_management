class Api::V1::UsersController < ApplicationController
    swagger_controller :user_sessions, 'Users Management'

    swagger_api :profile do
      summary 'Profile of the User'
    end

    def profile
      @user = current_user
      render :profile, status: :ok
    end
end
