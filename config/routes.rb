
Rails.application.routes.draw do


  root 'page#home'

  devise_for :users, :path => 'account'

  resources :users

  resources :stocks, only: ["index"]
  resources :industries, only: ["index"]
  resources :portfolios

  get 'page/about'

  get 'page/faqs'

  get 'page/contact'

end
