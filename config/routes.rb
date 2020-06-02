Rails.application.routes.draw do
  resources :members do
    get :invite, on: :collection
    member do
      patch :resend_invitation
    end
  end
  resources :tenants
  devise_for :users
  root 'home#index'
  get 'home/index'
end
