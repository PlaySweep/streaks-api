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

ActiveRecord::Schema.define(version: 2021_03_20_143225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "country", default: "United States"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "round_id"
    t.integer "status", default: 0
    t.integer "picks_won_count", default: 0
    t.boolean "bonus", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id", "user_id"], name: "index_cards_on_round_id_and_user_id", unique: true
    t.index ["round_id"], name: "index_cards_on_round_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "matchups", force: :cascade do |t|
    t.bigint "round_id"
    t.string "description"
    t.integer "status", default: 0
    t.integer "order", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_matchups_on_round_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "prize_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prize_id"], name: "index_orders_on_prize_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "picks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "matchup_id"
    t.bigint "selection_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matchup_id"], name: "index_picks_on_matchup_id"
    t.index ["selection_id"], name: "index_picks_on_selection_id"
    t.index ["user_id"], name: "index_picks_on_user_id"
  end

  create_table "prizes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "level", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.integer "inventory", default: 0
    t.integer "is_type", default: 0
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "prize_id"
    t.boolean "used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prize_id"], name: "index_rewards_on_prize_id"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.bigint "account_id"
    t.integer "status", default: 0
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rounds_on_account_id"
  end

  create_table "selections", force: :cascade do |t|
    t.bigint "matchup_id"
    t.string "description"
    t.integer "status", default: 0
    t.integer "order", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["matchup_id"], name: "index_selections_on_matchup_id"
  end

  create_table "streaks", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "previous", default: 0
    t.integer "current", default: 0
    t.integer "highest", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_streaks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "account_id"
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.string "email"
    t.string "password_digest"
    t.boolean "active", default: true
    t.boolean "eligible", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "referral_code"
    t.date "dob"
    t.integer "referred_by_id"
    t.index ["account_id"], name: "index_users_on_account_id"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "cards", "rounds"
  add_foreign_key "cards", "users"
  add_foreign_key "matchups", "rounds"
  add_foreign_key "orders", "prizes"
  add_foreign_key "orders", "users"
  add_foreign_key "picks", "matchups"
  add_foreign_key "picks", "selections"
  add_foreign_key "picks", "users"
  add_foreign_key "rewards", "prizes"
  add_foreign_key "rewards", "users"
  add_foreign_key "rounds", "accounts"
  add_foreign_key "selections", "matchups"
  add_foreign_key "streaks", "users"
  add_foreign_key "users", "accounts"
end
