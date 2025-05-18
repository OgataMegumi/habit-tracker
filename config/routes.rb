Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :users, only: [:show]

  resources :tasks do
    resources :task_logs, only: [ :create ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
