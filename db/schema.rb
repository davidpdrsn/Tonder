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

ActiveRecord::Schema.define(version: 20160415224257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "images", force: :cascade do |t|
    t.text     "url"
    t.integer  "tinder_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "images", ["tinder_user_id"], name: "index_images_on_tinder_user_id", using: :btree

  create_table "likers", force: :cascade do |t|
    t.text     "facebook_id"
    t.text     "facebook_token"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "running",        default: false
    t.text     "error"
    t.datetime "failed_at"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "tinder_user_id"
    t.integer  "liker_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "likes", ["liker_id"], name: "index_likes_on_liker_id", using: :btree
  add_index "likes", ["tinder_user_id"], name: "index_likes_on_tinder_user_id", using: :btree

  create_table "tinder_users", force: :cascade do |t|
    t.string   "tinder_id",  null: false
    t.string   "name",       null: false
    t.text     "bio",        null: false
    t.integer  "gender",     null: false
    t.datetime "birth_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tinder_users", ["tinder_id"], name: "index_tinder_users_on_tinder_id", unique: true, using: :btree

end