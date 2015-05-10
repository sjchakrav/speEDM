# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150510193348) do

  create_table "artist_genres", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "genre_id"
  end

  create_table "artist_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "profile_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "playlist_tracks", force: :cascade do |t|
    t.integer "track_id"
    t.integer "playlist_id"
  end

  add_index "playlist_tracks", ["playlist_id"], name: "index_playlist_tracks_on_playlist_id"
  add_index "playlist_tracks", ["track_id"], name: "index_playlist_tracks_on_track_id"

  create_table "playlists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "playlists", ["user_id"], name: "index_playlists_on_user_id"

  create_table "tracks", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.datetime "release_date"
    t.string   "source"
    t.integer  "artist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "email"
    t.string   "image_url"
    t.string   "profile_url"
    t.string   "oauth_refresh_token"
    t.integer  "oauth_expires_at"
  end

end
