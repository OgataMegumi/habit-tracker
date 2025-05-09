Rails.application.routes.draw do
  devise_for :users

  resources :tasks do
    resources :task_logs, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
