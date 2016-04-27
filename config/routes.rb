Rails.application.routes.draw do

  root 'page#home'

  get 'logout', to: 'sessions#destroy'

  get 'steps', to: 'portfolios#step'

  get 'pass', to: 'stocks_users#pass'

  get '/portfolios/:id/getting_started', to: 'portfolios#getting_started', as: 'getting_started'

  resources :users, only: ["new", "create"]

  resources :portfolios

  resources :stocks_users, only: ["create"]

  resources :stocks, only: ["show"]

  resources :industries, only: ["index", "show"]

  resources :sessions, only: ["create", "destroy"]

  get 'test', to: 'page#test'

  get "portfolios/:id/fetch", :to => "portfolios#fetch"
  
end
