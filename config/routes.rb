Rails.application.routes.draw do
  resources :members
  resources :tenants
  devise_for :users
  root 'home#index'
  get 'home/index'
end
