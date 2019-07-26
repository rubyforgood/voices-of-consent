Rails.application.routes.draw do
  resources :locations
  resources :meetings
  resources :volunteers
  resources :box_requests
  resources :requesters
  resources :meetings
  resources :meeting_types

  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'box_design/claim/:box_id', to: 'box_design#claim'
  post 'box_design/mark_as_designed', to: 'box_design#mark_as_designed'
end
