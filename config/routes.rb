Rails.application.routes.draw do
  resources :recipes
  resources :users, only: [:index, :delete, :show]

  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  delete "/logout", to: "sessions#destroy"
  get "/recipes", to: "recipes#index"
end
