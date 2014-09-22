Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root to: "dashboard#index", as: "dashboard"
end
