Rails.application.routes.draw do
  root to: 'pages#home'

  # Routes for users
  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update] do
    # Routes for pets
    resources :pets, except: :show
  end

  # Users custom routes
  patch '/make_available/', to: 'users#make_available'
  patch '/make_unavailable/', to: 'users#make_unavailable'
  get '/my-profile/', to: 'users#my_profile', as: 'my-profile'

  # Routes for consultations
  resources :consultations, only: [:new, :create, :edit, :update, :destroy] do
    # Message route
    resources :messages, only: :create
  end

  # Consultations custom routes
  get '/my-consultations/', to: 'consultations#my_consultations', as: 'my-consultations'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
