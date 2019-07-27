require 'sidekiq/web'

Rails.application.routes.draw do
  resources :purchases
  devise_for :users, controllers: {
    passwords: 'users/passwords', sessions: "users/sessions"
  }
  devise_scope :users do
    authenticated :user do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  resources :locations
  resources :meetings
  resources :boxes
  resources :volunteers
  resources :box_requests
  resources :requesters
  resources :meeting_types
  resources :inventory_types

  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
