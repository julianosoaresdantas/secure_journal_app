# config/routes.rb
Rails.application.routes.draw do
  root to: "journal_entries#index"
  devise_for :users
  resources :journal_entries  
  resource :two_factor_authentication, only: [:show, :create], controller: 'two_factor_authentication'
   #root "pages#about" # <-- Change this line

  get "about", to: "pages#about"
end
