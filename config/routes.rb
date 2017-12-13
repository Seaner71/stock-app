Rails.application.routes.draw do
  resources :stocks
  devise_for :users
  get 'home/index'
  root to: 'home#index'
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/' => 'home#index'
end
