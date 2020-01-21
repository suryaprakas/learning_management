Rails.application.routes.draw do
  devise_for :users,
  controllers: { sessions: 'user_sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
    post 'sign_up' => 'user_sessions#sign_up'
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          get :profile
        end
      end
    end
  end
end
