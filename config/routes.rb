Rails.application.routes.draw do
<<<<<<< HEAD
  resources :locations
  resources :meetings
=======
  resources :volunteers
  resources :box_requests
>>>>>>> develop
  resources :requesters
  resources :meetings

  get 'login_demo/index'
  get 'contact', to: 'home#contact'
  get 'admin', to: 'home#admin'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
