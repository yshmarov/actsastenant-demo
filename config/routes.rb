Rails.application.routes.draw do
  resources :members do
    get :invite, on: :collection
  end
  resources :tenants
  devise_for :users
  root 'home#index'
  get 'home/index'
end
