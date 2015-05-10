# routes.rb

resources :users, only: [:new, :create, :show, :destroy] do
  resources :playlists, only: [:show]
end
# => 'users/1/playlists/1'
tables =>
users :playlists,

playlist :tracks, :artists, :user_id

models =>

user has_many :playlists

playlist :belongs_to user
