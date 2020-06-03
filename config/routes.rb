Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'

  devise_for :users

  resources :members do
    get :invite, on: :collection
    member do
      patch :resend_invitation
    end
  end

  resources :tenants do
    get :my, on: :collection
  end

  resources :users, only: [:index, :show]

end
