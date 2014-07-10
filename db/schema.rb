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

ActiveRecord::Schema.define(version: 20140706112740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "childcarerosters", force: true do |t|
    t.string   "district"
    t.string   "name"
    t.string   "person_charge"
    t.integer  "size"
    t.string   "tel"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",          default: "childcarerosters"
  end

  create_table "dinings", force: true do |t|
    t.string   "diningid"
    t.string   "store_id"
    t.string   "name"
    t.string   "breif"
    t.string   "address"
    t.string   "tel"
    t.string   "time"
    t.float    "lng"
    t.float    "lat"
    t.string   "code"
    t.string   "changetime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "dinings"
  end

  create_table "drugstores", force: true do |t|
    t.string   "state"
    t.string   "type"
    t.string   "name"
    t.string   "country"
    t.string   "district"
    t.string   "address"
    t.string   "tel"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "drugstores"
  end

  create_table "hospitals", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "tel"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "hospitals"
  end

  create_table "police_stations", force: true do |t|
    t.string   "country"
    t.string   "district"
    t.string   "name"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "police_stations"
  end

  create_table "real_price_deals", force: true do |t|
    t.string   "area"
    t.string   "things"
    t.string   "location"
    t.float    "size"
    t.string   "ciy_part"
    t.string   "non_city_part"
    t.string   "non_city_sub"
    t.integer  "date"
    t.string   "items"
    t.string   "tranf"
    t.string   "height"
    t.string   "tpye"
    t.string   "usage"
    t.string   "material"
    t.integer  "compele_year"
    t.string   "tranf_area"
    t.string   "house"
    t.string   "hall"
    t.string   "toilet"
    t.string   "part_house"
    t.string   "org"
    t.integer  "total_price"
    t.float    "price_per_m"
    t.string   "car_tpye"
    t.string   "car_area"
    t.integer  "car_price"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",          default: "real_price_deals"
  end

  create_table "rent_houses", force: true do |t|
    t.string   "owner"
    t.string   "address"
    t.string   "structure"
    t.string   "size"
    t.string   "year"
    t.string   "floor"
    t.string   "email"
    t.string   "tel"
    t.string   "breif"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "type"
    t.float    "lat"
    t.float    "lng"
    t.string   "data",        default: "rent_houses"
    t.string   "use"
    t.string   "district"
    t.string   "around_list"
    t.string   "img"
    t.integer  "price"
  end

  create_table "sale_houses", force: true do |t|
    t.string   "owner"
    t.string   "address"
    t.string   "structure"
    t.string   "price"
    t.string   "size"
    t.string   "year"
    t.string   "floor"
    t.string   "email"
    t.string   "tel"
    t.string   "breif"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "type"
    t.float    "lat"
    t.float    "lng"
    t.string   "data",        default: "sale_houses"
    t.string   "use"
    t.string   "district"
    t.string   "around_list"
    t.string   "img"
  end

  create_table "stations", force: true do |t|
    t.string   "country"
    t.string   "area"
    t.string   "station"
    t.string   "address"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "stations"
  end

  create_table "stores", force: true do |t|
    t.string   "address"
    t.string   "code"
    t.string   "district"
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",       default: "stores"
  end

  create_table "tainan_markets", force: true do |t|
    t.string   "phone"
    t.string   "business_hours"
    t.string   "name"
    t.string   "district"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",           default: "tainan_markets"
  end

  create_table "tainan_schools", force: true do |t|
    t.string   "fax"
    t.string   "schoolid"
    t.string   "tel"
    t.string   "district"
    t.string   "schooltype"
    t.string   "schoolname"
    t.string   "edu_code"
    t.string   "country"
    t.string   "region"
    t.string   "countryname"
    t.string   "merger"
    t.float    "lat"
    t.float    "lng"
    t.string   "address"
    t.string   "schooltype2"
    t.string   "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data",        default: "tainan_schools"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
