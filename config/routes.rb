Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  as :user do
    get "users/edit", to: "devise/registrations#edit", as: "edit_user_registration"
    patch "users/:id", to: "devise/registrations#update", as: "user_registration"
  end

  mount_griddler

  require "sidekiq/web"
  mount Sidekiq::Web => "/jobs"

  get "/admin_dashboard", to: "admin_dashboard#show", as: :admin_dashboard
  get "/landing", to: "landing#show", as: :new_registration
  get "/search", to: "searches#show"

  get "/pages/ohlife_refugees", to: redirect("/pages/ohlife-alternative")

  resources :cancellations, only: [:create]
  resource :credit_card, only: [:edit, :update]
  resources :entries, only: [:index]
  resource :export, only: [:new]
  resources :imports, only: [:new, :create]
  resource :settings, only: [:edit, :update]
  resources :subscriptions, only: [:create]

  root to: "entries#index"
end
