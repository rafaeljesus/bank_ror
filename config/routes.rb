Rails.application.routes.draw do
  post 'user/create'

  get 'health_check/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
