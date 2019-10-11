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

  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  # resources :requesters, only: %i[new thank_you], controller: :requesters

  get 'requesters/new', to: 'requesters#new'
  post 'box_request_triage',                       to: "box_request_triage#create"
  get 'requesters/thank_you',                      to: 'requesters#thank_you',           as: 'box_request_thank_you'


  get 'box_requests/:id/:phase/claim_thank_you',   to: "box_requests#claim_thank_you",   as: 'box_request_claim_thank_you'
  get 'box_requests/:id/:phase/already_claimed',   to: 'box_requests#already_claimed',   as: 'box_request_already_claimed'
  get 'box_requests/:id/:phase/decline_thank_you', to: 'box_requests#decline_thank_you', as: 'box_request_decline_thank_you'

  # box_requests/:id (create) isn't needed bc the /requesters/new route creates box_requests
  get  'box_requests/:id/claim',                   to: "box_requests#claim",             as: 'box_request_claim'
  get  'box_requests/:id/decline',                 to: "box_requests#decline",           as: 'box_request_decline'
  # box_requests/:id/complete is handled via box_requests EDIT/UPDATE

  get  'box_design/:box_id',                       to: 'box_design#new',                 as: "box_design_new"
  get  'box_design/:box_id/claim',                 to: 'box_design#claim',               as: 'box_design_claim'
  get  'box_design/:box_id/decline',               to: "box_design#decline",             as: 'box_design_decline'
  get  'box_design/:box_id/complete',              to: 'box_design#complete',            as: 'box_design_complete'

  get  'box_research/:box_id',                     to: 'box_research#new',               as: "box_research_new"
  get  'box_research/:box_id/claim',               to: 'box_research#claim',             as: 'box_research_claim'
  get  'box_research/:box_id/decline',             to: "box_research#decline",           as: 'box_research_decline'
  get  'box_research/:box_id/complete',            to: 'box_research#complete',          as: 'box_research_complete'

  get  'box_assembly/:box_id',                     to: 'box_assembly#new',               as: "box_assembly_new"
  get  'box_assembly/:box_id/claim',               to: 'box_assembly#claim',             as: 'box_assembly_claim'
  get  'box_assembly/:box_id/decline',             to: "box_assembly#decline",           as: 'box_assembly_decline'
  get  'box_assembly/:box_id/complete',            to: 'box_assembly#complete',          as: 'box_assembly_complete'

  get  'box_shipment/:box_id',                     to: 'box_shipment#new',               as: "box_shipment_new"
  get  'box_shipment/:box_id/claim',               to: 'box_shipment#claim',             as: 'box_shipment_claim'
  get  'box_shipment/:box_id/decline',             to: "box_shipment#decline",           as: 'box_shipment_decline'
  get  'box_shipment/:box_id/complete',            to: 'box_shipment#complete',          as: 'box_shipment_complete'

  get  'box_follow_up/:box_id',                    to: 'box_follow_up#new',              as: "box_follow_up_new"
  get  'box_follow_up/:box_id/claim',              to: 'box_follow_up#claim',            as: 'box_follow_up_claim'
  get  'box_follow_up/:box_id/decline',            to: "box_follow_up#decline",          as: 'box_follow_up_decline'
  get  'box_follow_up/:box_id/complete',           to: 'box_follow_up#complete',         as: 'box_follow_up_complete'

  post 'volunteer_application',                    to: "volunteer_application#create"
  get 'volunteers/thank_you',                      to: 'volunteers#thank_you'

  # React Component Selection Lists
  get 'requesters/all',       to: 'requesters#index_for_selections'
  get 'volunteers/all',       to: 'volunteers#index_for_selections'
  get 'box_requests/all',     to: 'box_requests#index_for_selections'

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
  resource  :user_management, only: %i[show create destroy], controller: :user_management
  resources :volunteers
  resources :abuse_types, only: %i[index]

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
