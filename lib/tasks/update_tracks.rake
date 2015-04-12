task :update_tracks => :environment do
  Artist.update_tracks
end