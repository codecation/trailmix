Rails.application.routes.draw do
  devise_for :users

  mount_griddler

  require "sidekiq/web"
  mount Sidekiq::Web => "/jobs"

  get "/landing", to: "landing#show", as: :new_registration

  resources :subscriptions, only: [:create]
  resources :imports, only: [:new, :create]
  resource :settings, only: [:edit, :update]

  get "/search", to: "searches#show"

  root to: "dashboard#index", as: "dashboard"
end
