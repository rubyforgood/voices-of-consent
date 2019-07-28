require 'sidekiq/web'

Rails.application.routes.draw do
  resources :attendances
  resources :box_request_abuse_types
  resources :purchases
  resources :message_logs
  devise_for :users, controllers: {
    passwords: 'users/passwords', sessions: "users/sessions", invitations: "users/invitations"
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
  resource :user_management, only: %i[show create destroy], controller: :user_management

  post 'box_request_triage', to: "box_request_triage#create"
  get 'box_request/already_claimed', to: 'box_requests#already_claimed'
  post 'box_request/claim', to: "box_request#claim"

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
