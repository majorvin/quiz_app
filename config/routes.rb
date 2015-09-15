Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :edit, :update]

  namespace :question_set do
    resources :categories, only: [:index]
  end

  root "dashboard#index"
end
