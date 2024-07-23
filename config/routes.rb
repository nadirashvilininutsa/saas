class SubdomainConstraint
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end
end

Rails.application.routes.draw do
  root "home#index"

  # get "users/index"
  constraints subdomain: /.*/ do
    resources :projects do
      member do
        patch :complete_and_archive
        patch :reopen
      end
      resources :artifacts, only: [:show, :create, :update, :destroy]
    end
  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions', invitations: 'users/invitations' }
  resources :users, only: [:index, :destroy] do
    member do
      patch :toggle_user_status
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
end
