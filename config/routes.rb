Rails.application.routes.draw do
  root to: 'pages#home'

<<<<<<< HEAD
<<<<<<< HEAD
  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update]
=======
=======
  devise_for :users, path: 'users'
  resources :users, only: [:edit, :update]
  
>>>>>>> fe596a402d28073c6cd5d767baa3b7f4df73a484
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
<<<<<<< HEAD
  get '/my-consultations/', to: 'consultations#my_consultations'
>>>>>>> 127f499cf63c1016c50ae0a1de1531c377206a79

=======
>>>>>>> fe596a402d28073c6cd5d767baa3b7f4df73a484
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
