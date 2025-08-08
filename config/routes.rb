# config/routes.rb
Rails.application.routes.draw do
  root to: "journal_entries#index"
  devise_for :users
  resources :journal_entries  
  #root "pages#about" # <-- Change this line

  get "about", to: "pages#about"
end
