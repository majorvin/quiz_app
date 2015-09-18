Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :edit, :update]

  get "/available", to: "question_set/categories#exam_list"

  namespace :exam do
    resources :lists, only: [:show] do

      collection do
        get 'find'
      end
    end

    resources :questions, only: [:update]
  end

  namespace :question_set do
    resources :categories, only: [:index, :new, :create, :edit, :update, :show] do


      member do
        put "archive"
      end
    end

    resources :questions, only: [:create, :show, :update, :index] do
      member do
        put "archive"
      end
    end
  end

  root "dashboard#index"
end
