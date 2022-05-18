Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Routes for pets
  resources :pets, only: [:new, :create]
  get '/my-pets/', to: 'pets#my_pets'
  get '/my-pets/:id/edit', to: 'pets#edit'
  patch '/my-pets/:id/', to: 'pets#update'
  delete '/my-pets/:id/', to: 'pets#destroy'

  # Routes for consultations
  resources :consultations, only: [:new, :create, :edit, :update, :destroy] do
    # Message route
    resources :messages, only: :create
  end
  get '/my-consultations/', to: 'consultations#my_consultations'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
