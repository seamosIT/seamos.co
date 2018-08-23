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

ActiveRecord::Schema.define(version: 20180823224722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_titles", force: :cascade do |t|
    t.string   "title"
    t.string   "period"
    t.string   "institute"
    t.string   "annotation"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_academic_titles_on_user_id", using: :btree
  end

  create_table "email_lists", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "external_links", force: :cascade do |t|
    t.string   "url"
    t.integer  "poll_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "is_project_link", default: false
    t.index ["poll_id"], name: "index_external_links_on_poll_id", using: :btree
  end

  create_table "interests", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_interests_on_tag_id", using: :btree
    t.index ["user_id"], name: "index_interests_on_user_id", using: :btree
  end

  create_table "polls", force: :cascade do |t|
    t.string   "title",                          null: false
    t.text     "description",                    null: false
    t.date     "closing_date",                   null: false
    t.integer  "user_id"
    t.string   "totals"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "poll_image"
    t.boolean  "active",       default: false
    t.integer  "poll_type"
    t.string   "objective"
    t.string   "summary"
    t.string   "question"
    t.integer  "state"
    t.string   "closing_hour", default: "23:59"
    t.index ["title"], name: "index_polls_on_title", using: :btree
    t.index ["user_id"], name: "index_polls_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_roles_on_code", unique: true, using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "email_list_id"
    t.index ["email_list_id"], name: "index_subscriptions_on_email_list_id", using: :btree
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_taggings_on_poll_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tag_image"
    t.string   "tag_icon"
    t.string   "tag_color"
    t.string   "thumbnail"
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_surname"
    t.string   "second_surname"
    t.string   "names"
    t.string   "uid"
    t.boolean  "approved"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "role_type"
    t.string   "admin_photo"
    t.string   "organization"
    t.string   "bio"
    t.date     "birthday"
    t.string   "birthplace"
    t.integer  "last_election_vote_count"
    t.text     "represented_organizations"
    t.string   "major_electoral_representation_localities"
    t.string   "other_periods_elected"
    t.integer  "current_corporation_commission"
    t.text     "proposed_initiatives_to_date"
    t.string   "twitter_username"
    t.string   "provider"
    t.string   "provider_image"
    t.string   "encrypted_password",                        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  end

  create_table "vote_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_vote_types_on_poll_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "poll_id"
    t.integer  "user_id"
    t.integer  "vote_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["poll_id"], name: "index_votes_on_poll_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
    t.index ["vote_type_id"], name: "index_votes_on_vote_type_id", using: :btree
  end

  add_foreign_key "academic_titles", "users"
  add_foreign_key "external_links", "polls"
  add_foreign_key "interests", "tags"
  add_foreign_key "interests", "users"
  add_foreign_key "polls", "users"
  add_foreign_key "subscriptions", "email_lists"
  add_foreign_key "taggings", "polls"
  add_foreign_key "taggings", "tags"
  add_foreign_key "vote_types", "polls"
  add_foreign_key "votes", "polls"
  add_foreign_key "votes", "users"
end
