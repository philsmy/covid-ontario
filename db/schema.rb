# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_24_092527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "mobility_data", force: :cascade do |t|
    t.string "country_region_code"
    t.string "country_region"
    t.string "sub_region_1"
    t.string "sub_region_2"
    t.date "date"
    t.integer "retail_and_recreation_percent_change_from_baseline"
    t.integer "grocery_and_pharmacy_percent_change_from_baseline"
    t.integer "parks_percent_change_from_baseline"
    t.integer "transit_stations_percent_change_from_baseline"
    t.integer "workplaces_percent_change_from_baseline"
    t.integer "residential_percent_change_from_baseline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_region_code", "sub_region_1", "date"], name: "country_region_date", unique: true
  end

  create_table "patient_data", force: :cascade do |t|
    t.integer "external_id"
    t.date "episode_date"
    t.string "age_group"
    t.string "gender"
    t.string "acquisition_info"
    t.string "outcome"
    t.string "reporter"
    t.string "reporter_address"
    t.string "reporter_city"
    t.string "reporter_postal_code"
    t.string "reporter_website"
    t.float "reporter_latitude"
    t.float "reporter_longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.string "region"
    t.index ["external_id", "country", "region"], name: "index_patient_data_on_external_id_and_country_and_region", unique: true
  end

end
