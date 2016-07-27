Rails.application.routes.draw do
  resources :token, only: [:create]
  resources :health_check, only: [:index]
  resources :users, only: [:create]

  post 'accounts', to: 'accounts#create'
  post 'accounts/:id/deposit', to: 'accounts#deposit'
  post 'accounts/:id/withdraw', to: 'accounts#withdraw'
  post 'accounts/:id/transfer', to: 'accounts#transfer'
end
