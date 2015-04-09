class User < ActiveRecord::Base
  has_many :artist_users
  has_many :artists, through: :artist_users

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.info.id).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.info.id
    user.name = auth.info.display_name
    user.email = auth.info.email
    user.image_url = auth.info.images.first.url
    user.profile_url = auth.info.external_urls[:spotify]
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_expires_at = auth["credentials"]["expires_at"]
    user.oauth_refresh_token = auth["credentials"]["refresh_token"]
    user.save
    end
  end
end