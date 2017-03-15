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

ActiveRecord::Schema.define(version: 20170315052942) do

  create_table "estates", force: :cascade do |t|
    t.string   "estate_id"
    t.string   "origin_company"
    t.string   "title"
    t.string   "property_type"
    t.string   "agency"
    t.float    "price"
    t.string   "currency"
    t.string   "unit"
    t.integer  "floor_area"
    t.integer  "rooms"
    t.integer  "bathrooms"
    t.string   "city"
    t.string   "city_area"
    t.string   "region"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "picture_ids"
    t.date     "date"
    t.time     "time"
    t.boolean  "published"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "description"
    t.index ["estate_id"], name: "index_estates_on_estate_id", unique: true
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "estate_id"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estate_id"], name: "index_pictures_on_estate_id"
  end

end
