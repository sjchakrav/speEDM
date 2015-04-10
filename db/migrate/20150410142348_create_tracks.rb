class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :image_url
      t.string :url
      t.datetime :release_date
      t.string :source
      t.references :artist
      t.timestamps null: false
    end
    add_foreign_key :tracks, :artists
  end
end
