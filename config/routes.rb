Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
      resources :marks, only: :update
      resources :top_marks, only: :index
      resources :ip_logins, only: :index
    end
  end
end
