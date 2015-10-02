Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :certification do
    resources :tracks do
      resources :categories, only: [:new] do
        collection do
          put "batch_update"
          put "batch_destroy"
        end
      end
    end
  end

  resources :users, only: [:index, :edit, :update] do
    get 'results'
  end

  get "/available", to: "question_set/categories#exam_list"

  namespace :exam do
    resources :lists, only: [:show, :update] do

      collection do
        get 'find'
      end
    end

    resources :questions, only: [:update]
  end

  namespace :question_set do
    resources :categories, only: [:index, :new, :create, :edit, :update, :show] do
      resources :questions do

        collection do
          match 'search' => 'questions#search', via: [:get], as: :search
        end

        member do
          put "archive"
        end
      end

      get "results"

      member do
        put "archive"
      end
    end
  end

  root "question_set/categories#exam_list"
end
