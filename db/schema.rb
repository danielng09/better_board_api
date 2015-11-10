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

ActiveRecord::Schema.define(version: 20151031230342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "job_postings", force: :cascade do |t|
    t.string   "title",       null: false
    t.string   "company"
    t.string   "location",    null: false
    t.text     "description", null: false
    t.string   "url",         null: false
    t.datetime "date_posted", null: false
    t.string   "source",      null: false
    t.string   "source_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "job_postings", ["company", "title", "location"], name: "index_job_postings_on_company_and_title_and_location", unique: true, using: :btree
  add_index "job_postings", ["company"], name: "index_job_postings_on_company", using: :btree
  add_index "job_postings", ["date_posted"], name: "index_job_postings_on_date_posted", using: :btree
  add_index "job_postings", ["source"], name: "index_job_postings_on_source", using: :btree
  add_index "job_postings", ["source_id"], name: "index_job_postings_on_source_id", unique: true, using: :btree
  add_index "job_postings", ["title"], name: "index_job_postings_on_title", using: :btree
  add_index "job_postings", ["url"], name: "index_job_postings_on_url", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "pid",        null: false
    t.string   "name",       null: false
    t.string   "imageUrl"
    t.string   "email",      null: false
    t.time     "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree

end
