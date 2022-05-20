Rails.application.routes.draw do
  root to: 'pages#home'

  # Routes for users
  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update] do
    # Routes for pets
    resources :pets, except: :show
  end

  get '/my-profile/', to: 'users#my_profile'

  # Routes for consultations
  resources :consultations, only: [:new, :create, :edit, :update, :destroy] do
    # Message route
    resources :messages, only: :create
  end

  get '/my-consultations/', to: 'consultations#my_consultations'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
