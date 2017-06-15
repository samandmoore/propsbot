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

ActiveRecord::Schema.define(version: 20170615160909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "praise_recipients", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "praise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["praise_id"], name: "index_praise_recipients_on_praise_id"
    t.index ["user_id"], name: "index_praise_recipients_on_user_id"
  end

  create_table "praises", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "raw_comment"
    t.index ["user_id"], name: "index_praises_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "slack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "full_name"
    t.string "slack_user"
    t.index ["slack_id"], name: "index_users_on_slack_id", unique: true
    t.index ["slack_user"], name: "index_users_on_slack_user", unique: true
  end

end
