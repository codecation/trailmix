Rails.application.routes.draw do
  devise_for :users

  mount_griddler
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  require "sidekiq/web"
  mount Sidekiq::Web => "/jobs"

  get "/admin_dashboard", to: "admin_dashboard#show", as: :admin_dashboard
  get "/landing", to: "landing#show", as: :new_registration
  get "/search", to: "searches#show"

  get "/pages/ohlife_refugees", to: redirect("/pages/ohlife-alternative")

  resources :cancellations, only: [:create]
  resource :credit_card, only: [:edit, :update]
  resources :entries, only: [:index, :edit, :update]
  resource :export, only: [:new]
  resources :imports, only: [:new, :create]
  resource :settings, only: [:edit, :update]
  resources :subscriptions, only: [:create]

  root to: "landing#show"
end
