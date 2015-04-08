Rails.application.routes.draw do
  root to: 'static_pages#index'
  resources :artists #, only: [:index, :new, :create, :show]
  resources :users
  post "/search", to: 'search#search'

  # Authentication
  # get '/auth/spotify/callback', to: 'users#show'
  get '/auth/spotify/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'
  match 'auth/failure', to: redirect('/'), via: :get
end
