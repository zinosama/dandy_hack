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

ActiveRecord::Schema.define(version: 20160402220229) do

  create_table "illnesses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "illnesses", ["name"], name: "index_illnesses_on_name"

  create_table "illnesses_users", force: :cascade do |t|
    t.integer  "illness_id"
    t.integer  "user_id"
    t.datetime "date_contracted"
    t.datetime "date_recovered"
    t.string   "symptoms"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "illnesses_users", ["illness_id"], name: "index_illnesses_users_on_illness_id"
  add_index "illnesses_users", ["user_id"], name: "index_illnesses_users_on_user_id"

  create_table "medicine_records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicines", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "medicines", ["name"], name: "index_medicines_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "remember_digest"
    t.decimal  "weight"
    t.decimal  "height"
    t.integer  "blood_type"
    t.integer  "gender"
    t.integer  "age"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"

  create_table "users_vaccines", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "vaccine_id",     null: false
    t.integer  "date_injected",  null: false
    t.integer  "month_injected", null: false
    t.integer  "year_injected",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "users_vaccines", ["user_id"], name: "index_users_vaccines_on_user_id"
  add_index "users_vaccines", ["vaccine_id"], name: "index_users_vaccines_on_vaccine_id"

  create_table "vaccines", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "vaccines", ["name"], name: "index_vaccines_on_name"

end
