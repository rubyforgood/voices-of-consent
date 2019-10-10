require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
      passwords: 'users/passwords', sessions: "users/sessions", invitations: "users/invitations"
  }
  devise_scope :users do
    authenticated :user do
      mount Sidekiq::Web => '/sidekiq'
    end
  end

  resources :attendances
  resources :box_request_abuse_types
  resources :box_requests
  resources :boxes
  resources :inventory_adjustments
  resources :inventory_tallies
  resources :inventory_types
  resources :locations
  resources :meeting_types
  resources :meetings
  resources :message_logs
  resources :purchases
  resource :user_management, only: %i[show create destroy], controller: :user_management
  resources :volunteers
  resources :abuse_types, only: %i[index]

  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  # resources :requesters, only: %i[new thank_you], controller: :requesters

  get 'requesters/new', to: 'requesters#new'
  get 'requesters/thank_you', to: 'requesters#thank_you', as: 'box_request_thank_you'

  post 'box_request_triage', to: "box_request_triage#create"
  get 'box_requests/:id/claim_review', to: "box_requests#claim_review", as: 'box_request_claim_review'
  post 'box_requests/:id/claim_review', to: "box_requests#claim_review"
  get 'box_request/already_claimed', to: 'box_requests#already_claimed', as: 'box_request_already_claimed'

  get 'box_requests/:id/decline_review', to: "box_requests#decline_review", as: 'box_request_decline_review'
  post 'box_requests/:id/decline_review', to: "box_requests#decline_review"
  get 'box_requests/thanks_anyway', to: 'box_requests#thanks_anyway', as: 'box_request_thanks_anyway'

  get 'box_design/new', to: 'box_design#new'
  get 'box_design/claim/:box_id', to: 'box_design#claim'
  post 'box_design/mark_as_designed', to: 'box_design#mark_as_designed'

  get 'box_assembly/new', to: 'box_assembly#new'
  get 'box_assembly/claim/:box_id', to: 'box_assembly#claim'
  post 'box_assembly/mark_as_assembled/:box_id', to: 'box_assembly#mark_as_assemblyed'

  get 'box_shipment/claim/:box_id', to: 'box_shipment#claim'
  post 'box_shipment/mark_as_shipped', to: 'box_shipment#mark_as_shipped'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
