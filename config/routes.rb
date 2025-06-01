Rails.application.routes.draw do
  get "pages/about"
  root to: "home#index"
  devise_for :users

  resources :users do
    patch :toggle_completed_tasks
  end

  resources :tasks do
    member do
      post :toggle_today
      get :edit_modal
    end
  end

  resources :comments, only: [ :index, :new, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
