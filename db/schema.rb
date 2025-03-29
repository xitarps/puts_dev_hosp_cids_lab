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

ActiveRecord::Schema[8.0].define(version: 2025_03_29_232746) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cids", force: :cascade do |t|
    t.string "number"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hospital_user_cids", force: :cascade do |t|
    t.bigint "user_cid_id", null: false
    t.bigint "hospital_id", null: false
    t.datetime "treatment_start_at"
    t.datetime "treatment_end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_user_cids_on_hospital_id"
    t.index ["user_cid_id"], name: "index_hospital_user_cids_on_user_cid_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_cids", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "cid_id", null: false
    t.datetime "first_diagnosed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cid_id"], name: "index_user_cids_on_cid_id"
    t.index ["user_id"], name: "index_user_cids_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "hospital_user_cids", "hospitals"
  add_foreign_key "hospital_user_cids", "user_cids"
  add_foreign_key "user_cids", "cids"
  add_foreign_key "user_cids", "users"
end
