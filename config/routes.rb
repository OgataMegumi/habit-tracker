Rails.application.routes.draw do
  get "pages/about"
  root to: "home#index"
  devise_for :users
  resources :users, only: [:show]

  resources :tasks do
    member do
      post :toggle_today
      get :edit_modal
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
