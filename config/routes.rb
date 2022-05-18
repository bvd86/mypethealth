Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
