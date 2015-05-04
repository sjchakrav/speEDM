namespace :seed do
  desc "update tracks"
task :update_tracks => :environment do
  Artist.update_tracks
  end
end