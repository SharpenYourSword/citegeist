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

ActiveRecord::Schema.define(version: 20171123043325) do

  create_table "citations", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.text "document_type"
    t.text "booktitle"
    t.text "edition"
    t.text "journal"
    t.text "title"
    t.text "authors"
    t.text "year"
    t.text "volume"
    t.text "issue"
    t.text "pages"
    t.text "publisher"
    t.text "institution"
    t.text "month"
    t.text "address"
    t.text "doi"
    t.text "pubmed"
    t.text "url"
    t.text "note"
    t.text "editors"
    t.text "notation_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tagged_items", force: :cascade do |t|
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "group_id"
    t.integer "parent_tag_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_group_permissions", force: :cascade do |t|
    t.integer "user_group_id"
    t.string "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_id"], name: "index_user_group_permissions_on_user_group_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "remember_token"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean "global_admin", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
