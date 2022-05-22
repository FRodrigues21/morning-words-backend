Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users
      post "/login", to: "auth#create"
      get "/current_user", to: "auth#show"
      post "/sign_up", to: "users#create"
    end
  end
end
