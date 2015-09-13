Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:index]
  root "dashboard#index"
end
