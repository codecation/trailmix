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

ActiveRecord::Schema[6.1].define(version: 20160125013209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cancellations", force: :cascade do |t|
    t.string   "email",              null: false
    t.string   "stripe_customer_id", null: false
    t.text     "reason"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "import_id"
    t.date     "date",       null: false
    t.string   "photo"
  end

  create_table "imports", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ohlife_export", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",            null: false
    t.string   "stripe_customer_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "subscriptions", ["stripe_customer_id"], name: "index_subscriptions_on_stripe_customer_id", unique: true, using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",                           null: false
    t.string   "encrypted_password",     default: "",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "time_zone",              default: "Central Time (US & Canada)", null: false
    t.integer  "prompt_delivery_hour",   default: 2,                            null: false
    t.string   "reply_token",                                                   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reply_token"], name: "index_users_on_reply_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
