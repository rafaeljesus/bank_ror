Rails.application.routes.draw do
  resources :token, only: [:create]
  resources :health_check, only: [:index]
  resources :users, only: [:create]

  resources :accounts, only: [:create] do
    member do
      post :deposit
      post :withdraw
      post :transfer
    end
  end
end
