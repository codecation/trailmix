Rails.application.routes.draw do
  devise_for :users

  mount_griddler

  require "sidekiq/web"
  mount Sidekiq::Web => "/jobs"

  get "/landing", to: "landing#show"

  resources :subscriptions, only: [:create]

  root to: "dashboard#index", as: "dashboard"
end
