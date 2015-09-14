Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:index, :edit, :update]
  root "dashboard#index"
end
