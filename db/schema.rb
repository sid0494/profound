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

ActiveRecord::Schema.define(version: 20150331095624) do

  create_table "areas_of_expertise", id: false, force: :cascade do |t|
    t.string  "tag_id"
    t.integer "user_id"
  end

  add_index "areas_of_expertise", ["tag_id", "user_id"], name: "index_areas_of_expertise_on_tag_id_and_user_id"

  create_table "areas_of_interest", id: false, force: :cascade do |t|
    t.string  "tag_id"
    t.integer "user_id"
  end

  add_index "areas_of_interest", ["tag_id", "user_id"], name: "index_areas_of_interest_on_tag_id_and_user_id"

  create_table "messages", force: :cascade do |t|
    t.string   "content"
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "project_name",                            null: false
    t.string   "project_status",      default: "ongoing"
    t.string   "project_description"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "projects_tags", id: false, force: :cascade do |t|
    t.integer "project_id"
    t.integer "tag_id"
  end

  add_index "projects_tags", ["project_id", "tag_id"], name: "index_projects_tags_on_project_id_and_tag_id"

  create_table "tags", force: :cascade do |t|
    t.string   "tag_name",   limit: 30
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "tags", ["tag_name"], name: "index_tags_on_tag_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "profession"
    t.string   "institute"
    t.string   "degree"
    t.string   "contact"
    t.string   "security_que"
    t.string   "security_ans"
    t.float    "learning_rp",            default: 0.0
    t.float    "discussion_rp",          default: 0.0
    t.float    "project_rp",             default: 0.0
    t.integer  "projects_worked_on",     default: 0
    t.integer  "ongoing_projects",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
