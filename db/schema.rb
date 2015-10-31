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

  add_index "job_postings", ["company", "title", "location"], name: "index_job_postings_on_company_and_title_and_location", unique: true
  add_index "job_postings", ["company"], name: "index_job_postings_on_company"
  add_index "job_postings", ["date_posted"], name: "index_job_postings_on_date_posted"
  add_index "job_postings", ["description"], name: "index_job_postings_on_description"
  add_index "job_postings", ["source"], name: "index_job_postings_on_source"
  add_index "job_postings", ["source_id"], name: "index_job_postings_on_source_id", unique: true
  add_index "job_postings", ["title"], name: "index_job_postings_on_title"
  add_index "job_postings", ["url"], name: "index_job_postings_on_url", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
