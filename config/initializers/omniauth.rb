Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['SPOTIFY_ID'], ENV['SPOTIFY_SECRET'], scope: 'user-read-email user-follow-read'
end


