# config/routes.rb
Rails.application.routes.draw do
  get "errors/not_found"
  get "errors/internal_server_error"
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :journal_entries

  # --- This is the line we're checking/adding for the About page ---
  get "about", to: "home#about" # <--- ENSURE THIS LINE IS PRESENT AND UNCOMMENTED

  authenticated :user do
    root to: "journal_entries#index", as: :authenticated_root
  end

  root to: "home#index"

  # config/routes.rb
  #...
  get "/404", to: "errors#not_found"
  get "/500", to: "errors#internal_server_error"

end
