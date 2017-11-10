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

ActiveRecord::Schema.define(version: 20171109185220) do

  create_table "mailboxes", force: :cascade do |t|
    t.string   "email"
    t.string   "access_token"
    t.string   "api_key"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "reset_token"
    t.datetime "reset_token_generated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.index ["access_token"], name: "index_mailboxes_on_access_token"
    t.index ["api_key"], name: "index_mailboxes_on_api_key"
    t.index ["email"], name: "index_mailboxes_on_email"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "mailbox_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "subject"
    t.index ["mailbox_id"], name: "index_messages_on_mailbox_id"
  end

  create_table "whitelists", force: :cascade do |t|
    t.integer  "mailbox_id"
    t.string   "hostname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mailbox_id"], name: "index_whitelists_on_mailbox_id"
  end

end
