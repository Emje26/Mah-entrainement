# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Root route
  root 'home#index'

  # Users routes (full RESTful)
  resources :users do
    member do
      patch :activate
      patch :deactivate
    end
    collection do
      get :search
    end
  end

  # Items routes (full RESTful)
  resources :items do
    member do
      patch :publish
      patch :unpublish
    end
    collection do
      get :search
      get :featured
    end
  end

  # Sessions for authentication
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Static pages
  get 'about',   to: 'pages#about'
  get 'contact', to: 'pages#contact'

  # API namespace (optional)
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
      resources :items, only: %i[index show create update destroy]
    end
  end

  # Admin namespace (optional)
  namespace :admin do
    root 'dashboard#index'
    resources :users
    resources :items
  end
end
