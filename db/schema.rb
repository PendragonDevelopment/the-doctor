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

ActiveRecord::Schema.define(version: 20150410205316) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id", using: :btree

  create_table "host_events", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "host_id"
    t.integer  "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "host_events", ["event_id"], name: "index_host_events_on_event_id", using: :btree
  add_index "host_events", ["host_id"], name: "index_host_events_on_host_id", using: :btree

  create_table "hosts", force: :cascade do |t|
    t.integer  "rating"
    t.boolean  "active"
    t.string   "bio"
    t.integer  "user_id"
    t.date     "birthdate"
    t.integer  "status"
    t.string   "resume"
    t.string   "direct_deposit"
    t.string   "voided_check"
    t.string   "w9"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "hosts", ["user_id"], name: "index_hosts_on_user_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.string   "title"
    t.integer  "payment_amount"
    t.date     "payment_date"
    t.integer  "status"
    t.string   "transaction_record"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "appointment_id"
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.integer  "role"
    t.string   "last_name"
    t.string   "username"
    t.string   "profile_pic"
    t.string   "stripe_customer_id"
    t.integer  "host_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["host_id"], name: "index_users_on_host_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "events", "categories"
  add_foreign_key "host_events", "events"
  add_foreign_key "host_events", "hosts"
  add_foreign_key "hosts", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "hosts"
end