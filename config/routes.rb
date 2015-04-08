Rails.application.routes.draw do
  root to: 'static_pages#index'
  resources :artists #, only: [:index, :new, :create, :show]
  post "/static_pages/spotify", to: 'users#search'

  # Authentication
  get '/auth/spotify/callback', to: 'users#show'
  get 'auth/facebook/callback', to: 'sessions#create'
  get '/auth/spotify/callback', to: 'users#show'
  get 'signout', to: 'sessions#destroy'
  match 'auth/failure', to: redirect('/'), via: :get
end
