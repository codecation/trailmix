Rails.application.routes.draw do
  devise_for :users

  mount_griddler

  get "/landing", to: "landing#show"

  resources :subscriptions, only: [:create]

  root to: "dashboard#index", as: "dashboard"
end
