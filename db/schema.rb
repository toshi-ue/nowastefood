# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_31_081708) do

  create_table "contacts", charset: "utf8", force: :cascade do |t|
    t.integer "category", default: 0, null: false
    t.string "user_name"
    t.string "subject"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cuisines", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "status", default: 0, null: false
    t.integer "genre", default: 1, null: false
    t.string "name", null: false, comment: "料理名"
    t.integer "cooking_time", null: false, comment: "調理時間"
    t.string "description"
    t.string "main_image", null: false, comment: "メイン画像"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "favorites_count", default: 0, null: false
    t.index ["name"], name: "index_cuisines_on_name", unique: true
    t.index ["user_id"], name: "index_cuisines_on_user_id"
  end

  create_table "favorites", charset: "utf8", force: :cascade do |t|
    t.bigint "cuisine_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id", "user_id"], name: "index_favorites_on_cuisine_id_and_user_id", unique: true
    t.index ["cuisine_id"], name: "index_favorites_on_cuisine_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "foodcategories", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "食材区分名(肉、野菜、魚、炭水化物など)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_foodcategories_on_name", unique: true
  end

  create_table "foodstuffs", charset: "utf8", force: :cascade do |t|
    t.string "quantity", comment: "数量"
    t.bigint "cuisine_id", comment: "料理id"
    t.bigint "rawmaterial_id", comment: "原材料id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_foodstuffs_on_cuisine_id"
    t.index ["rawmaterial_id"], name: "index_foodstuffs_on_rawmaterial_id"
  end

  create_table "managers", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.boolean "editable", default: false, null: false
    t.index ["confirmation_token"], name: "index_managers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_managers_on_unlock_token", unique: true
  end

  create_table "procedures", charset: "utf8", force: :cascade do |t|
    t.string "cooking_detail"
    t.bigint "cuisine_id", comment: "料理id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_procedures_on_cuisine_id"
  end

  create_table "rawmaterials", charset: "utf8", force: :cascade do |t|
    t.string "name", null: false, comment: "原材料名"
    t.string "hiragana"
    t.bigint "user_id"
    t.bigint "unit_id"
    t.bigint "foodcategory_id"
    t.integer "expiry_period", default: 1, null: false
    t.integer "foodstuffs_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foodcategory_id"], name: "index_rawmaterials_on_foodcategory_id"
    t.index ["name"], name: "index_rawmaterials_on_name", unique: true
    t.index ["unit_id"], name: "index_rawmaterials_on_unit_id"
    t.index ["user_id"], name: "index_rawmaterials_on_user_id"
  end

  create_table "stocks", charset: "utf8", force: :cascade do |t|
    t.string "quantity", null: false
    t.bigint "rawmaterial_id"
    t.bigint "user_id"
    t.date "rotted_at", default: "2023-02-07", null: false
    t.datetime "consumed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rawmaterial_id"], name: "index_stocks_on_rawmaterial_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "todaysmenus", charset: "utf8", force: :cascade do |t|
    t.bigint "cuisine_id"
    t.bigint "user_id"
    t.integer "serving_count", default: 1, null: false
    t.integer "cooked_when"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_todaysmenus_on_cuisine_id"
    t.index ["user_id"], name: "index_todaysmenus_on_user_id"
  end

  create_table "units", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "nickname"
    t.string "email", default: "", null: false
    t.integer "default_serving_count", default: 1
    t.string "profile_image"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "cuisines", "users"
  add_foreign_key "favorites", "cuisines"
  add_foreign_key "favorites", "users"
  add_foreign_key "rawmaterials", "units"
  add_foreign_key "rawmaterials", "users"
  add_foreign_key "stocks", "rawmaterials"
  add_foreign_key "stocks", "users"
  add_foreign_key "todaysmenus", "cuisines"
  add_foreign_key "todaysmenus", "users"
end
