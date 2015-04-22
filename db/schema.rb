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

ActiveRecord::Schema.define(version: 20150422115635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "message"
    t.integer  "user_id"
    t.integer  "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["record_id"], name: "index_comments_on_record_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "title"
    t.integer  "boss_id"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "departments", ["boss_id"], name: "index_departments_on_boss_id", using: :btree
  add_index "departments", ["parent_id"], name: "index_departments_on_parent_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "type"
    t.text     "comment"
    t.text     "emails"
    t.datetime "date_from"
    t.datetime "date_to"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.boolean  "boss_approved"
    t.boolean  "bookkeeper_approved"
  end

  add_index "records", ["user_id"], name: "index_records_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "department_id"
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
    t.integer  "roles_mask"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "records"
  add_foreign_key "comments", "users"
  add_foreign_key "records", "users"
  add_foreign_key "users", "departments"
end
