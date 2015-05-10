require 'feature_helper'

RSpec.feature "Playlist show page", type: :feature do
  scenario "User sees a playlist" do
    user = create(:user)
    playlist = create(:playlist)

    visit "/users/#{user.id}/playlists/#{playlist.id}"

    expect(page).to have_text("Kanye West")
  end
end
