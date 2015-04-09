Rails.application.routes.draw do
  root to: 'static_pages#index'
  resources :artists, only: [:new, :create, :show, :destroy]
  resources :users, only: [:new, :create, :show, :destroy]
  resources :artist_users, only: [:new, :create, :show, :destroy]
  post "/search", to: 'search#search'

  # Authentication
  get '/auth/spotify/callback', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'
  match 'auth/failure', to: redirect('/'), via: :get
end
