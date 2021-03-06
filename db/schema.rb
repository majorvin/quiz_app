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

ActiveRecord::Schema.define(version: 20150925185824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certification_tracks", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "enabled",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "certification_tracks_categories", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "track_id",    null: false
  end

  add_index "certification_tracks_categories", ["category_id", "track_id"], name: "certification_tracks_categories_index", using: :btree

  create_table "exam_choices", force: :cascade do |t|
    t.integer "question_id",                 null: false
    t.string  "text",                        null: false
    t.boolean "answer",      default: false
  end

  create_table "exam_lists", force: :cascade do |t|
    t.integer  "category_id",    null: false
    t.integer  "user_id",        null: false
    t.string   "workflow_state"
    t.decimal  "grade"
    t.datetime "completed_at"
  end

  add_index "exam_lists", ["category_id"], name: "index_exam_lists_on_category_id", using: :btree
  add_index "exam_lists", ["user_id"], name: "index_exam_lists_on_user_id", using: :btree

  create_table "exam_questions", force: :cascade do |t|
    t.integer "list_id",                  null: false
    t.integer "question_set_question_id", null: false
    t.string  "value"
    t.string  "text",                     null: false
  end

  add_index "exam_questions", ["list_id"], name: "index_exam_questions_on_list_id", using: :btree

  create_table "question_set_categories", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "enabled",      default: false, null: false
    t.datetime "archived_at"
    t.integer  "max_question"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "question_set_categories", ["name"], name: "index_question_set_categories_on_name", using: :btree

  create_table "question_set_choices", force: :cascade do |t|
    t.integer  "question_id",                 null: false
    t.boolean  "answer",      default: false, null: false
    t.string   "text",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "question_set_choices", ["question_id"], name: "index_question_set_choices_on_question_id", using: :btree

  create_table "question_set_questions", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.string   "text",        null: false
    t.datetime "archived_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "question_set_questions", ["category_id"], name: "index_question_set_questions_on_category_id", using: :btree
  add_index "question_set_questions", ["text"], name: "index_question_set_questions_on_text", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.datetime "deleted_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "team"
    t.string   "position"
    t.integer  "track_id"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["track_id"], name: "index_users_on_track_id", using: :btree

  add_foreign_key "question_set_choices", "question_set_questions", column: "question_id"
  add_foreign_key "question_set_questions", "question_set_categories", column: "category_id"
end
