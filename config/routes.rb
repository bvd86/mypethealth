Rails.application.routes.draw do
  root to: 'pages#home'

  # Sidekiq Web UI, only for admins.
  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Routes for users
  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update] do
    delete '/remove_photo/', to: 'users#remove_photo'
    # Routes for pets
    resources :pets, except: :show do
      get '/consultations', to: 'consultations#pet_consultations'
    end
  end

  # Users custom routes
  patch '/make_available/', to: 'users#make_available'
  patch '/make_unavailable/', to: 'users#make_unavailable'
  get '/available_vets/', to: 'users#available_vets'
  get '/my-profile/', to: 'users#my_profile', as: 'my-profile'

  # Routes for consultations
  resources :consultations, only: [:show, :new, :create, :edit, :update, :destroy] do
    # Message route
    resources :messages, only: :create

    # Routes for feedbacks
    resources :feedbacks, only: [:show, :new, :create]

    # Routes for receipts
    resources :receipts, only: [:create, :show]
  end

  # Consultations custom routes
  get '/my-consultations/', to: 'consultations#my_consultations', as: 'my-consultations'
  get '/start_consultation/', to: 'consultations#start_consultation'
  patch '/end_consultation/', to: 'consultations#end_consultation'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
