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

ActiveRecord::Schema.define(version: 20141228205303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "breaks", force: true do |t|
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id"
  end

  add_index "breaks", ["match_id"], name: "index_breaks_on_match_id", using: :btree

  create_table "frames", force: true do |t|
    t.integer  "player_1_points"
    t.integer  "player_2_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "number_of_players"
    t.integer  "number_of_winners"
    t.integer  "number_of_dropots"
    t.integer  "best_of"
    t.integer  "win_points"
    t.integer  "loss_points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues_players", id: false, force: true do |t|
    t.integer "league_id"
    t.integer "player_id"
  end

  add_index "leagues_players", ["league_id", "player_id"], name: "index_leagues_players_on_league_id_and_player_id", using: :btree

  create_table "matches", force: true do |t|
    t.date     "date"
    t.integer  "player_1_frames"
    t.integer  "player_2_frames"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round_id"
    t.integer  "player_1_id"
    t.integer  "player_2_id"
  end

  add_index "matches", ["round_id"], name: "index_matches_on_round_id", using: :btree

  create_table "players", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "date_of_birth"
    t.string   "email"
    t.integer  "phone_number"
    t.integer  "max_break"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  add_index "rounds", ["league_id"], name: "index_rounds_on_league_id", using: :btree

  create_table "tables", force: true do |t|
    t.integer  "position"
    t.integer  "number_of_matches"
    t.integer  "points"
    t.integer  "number_of_wins"
    t.integer  "number_of_loss"
    t.integer  "number_of_win_frames"
    t.integer  "number_of_lose_frames"
    t.integer  "number_of_win_small_points"
    t.integer  "number_of_lose_small_points"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
  end

  add_index "tables", ["league_id"], name: "index_tables_on_league_id", using: :btree

end
