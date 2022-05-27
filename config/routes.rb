Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/posts/progress", to: "posts#progress"
      resources :posts
      get "/post", to: "posts#show"
      resources :users
      post "/login", to: "auth#create"
      get "/current_user", to: "auth#show"
      post "/sign_up", to: "users#create"
    end
  end
end
