Rails.application.routes.draw do
  # api
  namespace :api do
    namespace :v1 do
      post :signup, to: 'registrations#signup'
      resources :sessions, only: [:create, :destroy]
      delete 'sessions/destroy', to: 'sessions#destroy'
      post 'password_resets/new', to: 'password_resets#create'
      post 'password_resets/reset', to: 'password_resets#reset'
      resources :users, only: [:index]
    end
  end
end
