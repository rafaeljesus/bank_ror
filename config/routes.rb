Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :health_check, only: [:index]
end
