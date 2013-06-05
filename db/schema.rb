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

ActiveRecord::Schema.define(version: 20130603215222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "schools", force: true do |t|
    t.string   "name",        limit: 100, null: false
    t.string   "address",     limit: 50,  null: false
    t.string   "city",        limit: 50,  null: false
    t.string   "state",       limit: 100, null: false
    t.string   "zip",         limit: 15,  null: false
    t.string   "coordinates", limit: nil, null: false
    t.integer  "type_enum",               null: false
    t.integer  "state_enum",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["coordinates"], name: "index_schools_on_coordinates", using: :gist

  create_table "users", force: true do |t|
    t.string   "first_name",                      limit: 50,  null: false
    t.string   "last_name",                       limit: 50
    t.string   "email",                           limit: 100
    t.boolean  "emailable",                                   null: false
    t.string   "phone_country_code",              limit: 10,  null: false
    t.string   "phone_number",                    limit: 20,  null: false
    t.string   "time_zone",                       limit: 250
    t.integer  "school_id",                                   null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["phone_number"], name: "index_users_on_phone_number", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

end