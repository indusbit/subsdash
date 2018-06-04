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

ActiveRecord::Schema.define(version: 2018_06_04_105805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "oid"
    t.string "name"
    t.string "email"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oid"], name: "index_customers_on_oid"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "oid"
    t.string "interval"
    t.integer "interval_count"
    t.decimal "amount", precision: 18, scale: 4
    t.string "currency"
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interval"], name: "index_plans_on_interval"
    t.index ["oid"], name: "index_plans_on_oid"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "oid"
    t.bigint "customer_id"
    t.bigint "plan_id"
    t.datetime "started_at"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "cancelled_at"
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["oid"], name: "index_subscriptions_on_oid"
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "plans"
end
