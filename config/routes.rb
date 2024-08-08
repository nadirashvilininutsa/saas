Rails.application.routes.draw do
  resources :tasks
  root "home#index"

  resources :projects do
    member do
      patch :complete_and_archive
      patch :reopen
      post :add_project_employees
      # post :update_project_employees
      delete 'remove_project_employee/:user_id', to: 'projects#remove_project_employee', as: 'remove_project_employee'
    end
    resources :artifacts, only: [:show, :create, :destroy]
    resources :tasks, only: [:create] do
      member do
        patch :complete
        patch :reopen
      end
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', invitations: 'users/invitations' }
  
  resources :users, only: [:index, :destroy] do
    member do
      patch :change_role
      patch :update_permissions
    end
  end

  resources :organizations, only: [:show] do
    member do
      patch :change_plan
    end
  end

  resources :plans, only: [:index]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
end
