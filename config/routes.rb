Rails.application.routes.draw do
  devise_for :users

  mount_griddler

  require "sidekiq/web"
  mount Sidekiq::Web => "/jobs"

  get "/landing", to: "landing#show", as: :new_registration

  resources :subscriptions, only: [:create]
  resources :imports, only: [:new, :create]

  get "/settings", to: "settings#edit", as: :edit_settings
  put "/settings", to: "settings#update", as: :settings

  root to: "dashboard#index", as: "dashboard"
end
