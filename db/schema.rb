# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_30_040633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "external_url", null: false
    t.integer "jersey_number"
    t.string "position"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "roster_searches", force: :cascade do |t|
    t.integer "frequency", default: 0, null: false
    t.citext "team_abbr", null: false
    t.citext "position"
    t.integer "jersey_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.citext "first_name"
    t.citext "last_name"
    t.index ["team_abbr", "first_name", "last_name", "position"], name: "ix_unique_roster_search", unique: true
  end

  create_table "team_search_teams", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "team_search_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_search_teams_on_team_id"
    t.index ["team_search_id"], name: "index_team_search_teams_on_team_search_id"
  end

  create_table "team_searches", force: :cascade do |t|
    t.integer "frequency", default: 0, null: false
    t.citext "name"
    t.citext "abbr"
    t.citext "division"
    t.citext "conference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "abbr", "division", "conference"], name: "ix_unique_team_search", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbr", null: false
    t.string "external_url", null: false
    t.string "division"
    t.string "conference"
    t.integer "inaugural_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "players", "teams"
  add_foreign_key "team_search_teams", "team_searches"
  add_foreign_key "team_search_teams", "teams"
end
