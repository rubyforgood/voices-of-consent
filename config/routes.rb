Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'users/passwords', sessions: "users/sessions"
  }

  resources :locations
  resources :meetings
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
