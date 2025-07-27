Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users

  # Root path for authenticated users
  # Ensure Devise knows this is for the 'user' mapping
  authenticated :user do
    root to: "home#index", as: :authenticated_user_root # Renamed for clarity
  end

  # Root path for unauthenticated users (login page)
  # Ensure Devise knows this is for the 'user' mapping
  unauthenticated :user do # Added :user here
    root to: "devise/sessions#new", as: :unauthenticated_user_root # Renamed for clarity
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Entries routes
  resources :entries

  # User profile route
  get 'users/index', to: 'users#index', as: :users_index

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index" # Ensure this is commented out or removed if you're using authenticated/unauthenticated roots
end
