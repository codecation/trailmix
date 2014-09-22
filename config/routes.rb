Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  mount_griddler

  root to: "dashboard#index", as: "dashboard"
end
