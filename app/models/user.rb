class User < ActiveRecord::Base
  has_many :artist_users
  has_many :artists, through: :artist_users

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.provider = auth.provider 
    user.uid      = auth.uid
    user.name     = auth.info.name
    user.save
    end
  end
end
