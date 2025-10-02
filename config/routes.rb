Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks",
    confirmations: "users/confirmations"
  }

  root "pages#home"

  namespace :forum do
    resources :categories, only: %i[index create update destroy show] do
      collection do
        post :index
      end
      resources :topics, only: %i[create destroy]
    end

    resources :topics do
      patch :update_pinned, on: :member
      resources :posts, only: %i[create edit update destroy]
    end

    resources :tags, only: %i[index]
  end

  resource :profile, only: %i[show edit update], controller: "users/profiles" do
    collection do
      get :change_password, action: :edit_password
      patch :update_password
      delete :soft_delete
    end
  end
  resources :users, only: %i[show], controller: "users/profiles"

  get "about", to: "pages#about"
  get "faq", to: "pages#faq"
  get "privacy-policy", to: "pages#privacy_policy"
  get "up" => "rails/health#show", as: :rails_health_check

  get "/robots.txt" => "robots#show", defaults: { format: "txt" }
  get "/sitemap.xml.gz", to: "sitemaps#redirect_to_r2"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
end
