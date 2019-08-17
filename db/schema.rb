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

ActiveRecord::Schema.define(version: 20190816135053) do

  create_table "activities", force: :cascade do |t|
    t.integer  "company_id",     limit: 4
    t.text     "parameters",     limit: 65535
    t.string   "action",         limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id",       limit: 4
  end

  add_index "activities", ["company_id"], name: "index_activities_on_company_id", using: :btree
  add_index "activities", ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id",      limit: 4
    t.integer  "company_id",       limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_response_id", limit: 4
    t.integer  "option_id",        limit: 4
    t.text     "detail",           limit: 65535
  end

  add_index "answers", ["company_id"], name: "index_answers_on_company_id", using: :btree
  add_index "answers", ["option_id"], name: "index_answers_on_option_id", using: :btree
  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_response_id"], name: "index_answers_on_user_response_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "status",                  limit: 255
    t.datetime "cancelled_on"
    t.integer  "subscription_package_id", limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "subdomain",               limit: 255
  end

  create_table "company_settings", force: :cascade do |t|
    t.integer  "max_questions",                   limit: 4
    t.boolean  "supervisors_survey_permission",   limit: 1
    t.boolean  "supervisors_settings_permission", limit: 1
    t.boolean  "members_settings_permission",     limit: 1
    t.integer  "survey_expiry_days",              limit: 4
    t.integer  "company_id",                      limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "company_settings", ["company_id"], name: "index_company_settings_on_company_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.integer  "company_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "created_by_id", limit: 4
  end

  add_index "groups", ["company_id"], name: "index_groups_on_company_id", using: :btree

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer "group_id", limit: 4
    t.integer "user_id",  limit: 4
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id", using: :btree
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.text     "detail",      limit: 65535
    t.integer  "question_id", limit: 4
    t.integer  "company_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "options", ["company_id"], name: "index_options_on_company_id", using: :btree
  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "statement",     limit: 65535
    t.string   "question_type", limit: 255
    t.integer  "survey_id",     limit: 4
    t.integer  "company_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "required",      limit: 1
  end

  add_index "questions", ["company_id"], name: "index_questions_on_company_id", using: :btree
  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "subscription_packages", force: :cascade do |t|
    t.string   "subscription_package_name", limit: 255
    t.integer  "max_supervisors",           limit: 4
    t.integer  "max_members",               limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.string   "category",    limit: 255
    t.string   "image",       limit: 255
    t.string   "survey_type", limit: 255
    t.datetime "expiry"
    t.integer  "user_id",     limit: 4
    t.integer  "company_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "group_id",    limit: 4
  end

  add_index "surveys", ["company_id"], name: "index_surveys_on_company_id", using: :btree
  add_index "surveys", ["group_id"], name: "index_surveys_on_group_id", using: :btree
  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id", using: :btree

  create_table "user_responses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "survey_id",  limit: 4
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "company_id", limit: 4
  end

  create_table "user_settings", force: :cascade do |t|
    t.boolean  "emails_subscription", limit: 1
    t.boolean  "show_graphs",         limit: 1
    t.boolean  "show_history",        limit: 1
    t.integer  "company_id",          limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_settings", ["company_id"], name: "index_user_settings_on_company_id", using: :btree
  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "company_id",             limit: 4
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "role",                   limit: 255
    t.string   "initial_password",       limit: 255
    t.string   "image_file_name",        limit: 255
    t.string   "image_content_type",     limit: 255
    t.integer  "image_file_size",        limit: 4
    t.datetime "image_updated_at"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email", "company_id"], name: "index_users_on_email_and_company_id", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
