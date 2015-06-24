Rails.application.routes.draw do
  root "home#show"

  get    "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:edit, :update, :show]
  resources :matching, only: [:show, :update]

  get "/dashboard", to: "dashboard#show"
end
