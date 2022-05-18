Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :consultations do
    # Message route
    resources :messages, only: :create
  end
  get '/my-consultations/', to: 'consultations#my_consultations'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
