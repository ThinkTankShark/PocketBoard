
Rails.application.routes.draw do


  resources :stocks_users
  
  root 'page#home'

  devise_for :users, :path => 'account'


  resources :stocks, only: ["index"]
  resources :industries, only: ["index", "show"] do
   member do
     patch :select
   end
  end

  resources :portfolios

  get 'page/about'

  get 'page/faqs'

  get 'page/contact'

end
