Rails.application.routes.draw do
  root "home#show"

  get    "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:edit, :update, :show]

  get "/dashboard", to: "dashboard#show"
end
