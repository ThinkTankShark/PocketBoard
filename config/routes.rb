Rails.application.routes.draw do

  get 'logout', to: 'sessions#destroy'

  get 'steps', to: 'portfolios#step'

  root 'page#home'

  resources :users, only: ["new", "create"]

  resources :portfolios, only: ["index", "new", "create"]

  resources :stocks_users, only: ["create"]

  resources :stocks, only: ["show"]

  resources :industries, only: ["index", "show"]

  resources :sessions, only: ["create", "destroy"]
end
