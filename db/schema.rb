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

ActiveRecord::Schema.define(version: 20160510195418) do

  create_table "job_ads", force: :cascade do |t|
    t.string "employment_type",     limit: 255
    t.string "company",             limit: 255
    t.string "compensation",        limit: 255
    t.string "experience",          limit: 255
    t.string "industry",            limit: 255
    t.string "job_function",        limit: 255
    t.string "city_and_state",      limit: 255
    t.string "title",               limit: 255
    t.float  "latitude",            limit: 24
    t.float  "longitude",           limit: 24
    t.text   "company_description", limit: 65535
    t.text   "job_description",     limit: 65535
    t.text   "requirements",        limit: 65535
    t.text   "other",               limit: 65535
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company",  limit: 255
    t.string "industry", limit: 255
    t.string "title",    limit: 255
    t.string "location", limit: 255
  end

  create_table "jobs_users", id: false, force: :cascade do |t|
    t.integer "job_id",  limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
    t.integer "years",   limit: 4
  end

  add_index "jobs_users", ["user_id", "job_id"], name: "index_jobs_users_on_user_id_and_job_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "name",     limit: 255
    t.string "email",    limit: 255
    t.string "college",  limit: 255
    t.string "degree",   limit: 255
    t.string "about_me", limit: 255
  end

end
