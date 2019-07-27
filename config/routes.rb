require 'sidekiq/web'

Rails.application.routes.draw do
  resources :purchases
  resources :message_logs
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
  resources :inventory_adjustments
  
  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  get 'box_design/new', to: 'box_design#new'
  get 'box_design/claim/:box_id', to: 'box_design#claim'
  post 'box_design/mark_as_designed', to: 'box_design#mark_as_designed'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
