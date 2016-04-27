Rails.application.routes.draw do

  get 'logout', to: 'sessions#destroy'

  get 'steps', to: 'portfolios#step'

  root 'page#home'

  resources :users, only: ["new", "create"]

  resources :portfolios

  resources :stocks_users, only: ["create"]

  resources :stocks, only: ["show"]

  resources :industries, only: ["index", "show"]

  resources :sessions, only: ["create", "destroy"]

  get 'test', to: 'page#test'
end
