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

ActiveRecord::Schema.define(version: 20140218015346) do

  create_table "apps", force: true do |t|
    t.string   "name"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["token"], name: "index_apps_on_token", unique: true

  create_table "file_line_profiles", force: true do |t|
    t.integer  "file_profile_id"
    t.integer  "line_number"
    t.integer  "wall_time"
    t.integer  "cpu_time"
    t.integer  "calls"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_profiles", force: true do |t|
    t.integer  "file_source_id"
    t.integer  "profile_id"
    t.datetime "timestamp"
    t.integer  "total"
    t.integer  "total_cpu"
    t.integer  "child"
    t.integer  "child_cpu"
    t.integer  "exclusive"
    t.integer  "exclusive_cpu"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_sources", force: true do |t|
    t.integer  "app_id"
    t.string   "file_name"
    t.text     "contents"
    t.text     "hashed_contents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "file_sources", ["app_id", "hashed_contents"], name: "index_file_sources_on_app_id_and_hashed_contents", unique: true

  create_table "profiles", force: true do |t|
    t.integer  "app_id"
    t.string   "hostname"
    t.string   "pid"
    t.text     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.text     "file_sources"
  end

  add_index "profiles", ["app_id"], name: "index_profiles_on_app_id"

end
