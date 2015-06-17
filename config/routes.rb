Rails.application.routes.draw do
  # api
  namespace :api do
    namespace :v1 do
      post :signup, to: 'registrations#signup'
      resources :sessions, only: [:create, :destroy]
      delete 'sessions/destroy', to: 'sessions#destroy'
      resources :users, only: [:index]
    end
  end
end
