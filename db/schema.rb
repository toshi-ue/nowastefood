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

ActiveRecord::Schema.define(version: 20201209090020) do

  create_table "cookinghistories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cuisine_id", comment: "料理id"
    t.bigint "user_id", comment: "ユーザーid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_cookinghistories_on_cuisine_id"
    t.index ["user_id"], name: "index_cookinghistories_on_user_id"
  end

  create_table "cuisines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false, comment: "料理名"
    t.bigint "genre_id"
    t.integer "difficulty", limit: 1, default: 0, null: false, comment: "料理の難易度(enumで、低・中・高)"
    t.string "calories", comment: "摂取カロリー"
    t.integer "cooking_time", null: false, comment: "調理時間"
    t.string "description"
    t.string "main_image", null: false, comment: "メイン画像"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_cuisines_on_genre_id"
    t.index ["name"], name: "index_cuisines_on_name", unique: true
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cuisine_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_favorites_on_cuisine_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "foodcategories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false, comment: "食材区分名(肉、野菜、魚、炭水化物など)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_foodcategories_on_name", unique: true
  end

  create_table "foodstuffs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "quantity", comment: "数量"
    t.bigint "cuisine_id", comment: "料理id"
    t.bigint "rawmaterial_id", comment: "原材料id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_foodstuffs_on_cuisine_id"
    t.index ["rawmaterial_id"], name: "index_foodstuffs_on_rawmaterial_id"
  end

  create_table "genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cuisines_count", default: 0, null: false
  end

  create_table "managers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.index ["confirmation_token"], name: "index_managers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_managers_on_unlock_token", unique: true
  end

  create_table "nutrients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "rawmaterial_id"
    t.integer "lipid", comment: "脂質"
    t.integer "carbonhydrate", comment: "炭水化物"
    t.integer "protein", comment: "タンパク質"
    t.integer "vit_a", comment: "ビタミンA"
    t.integer "vit_d", comment: "ビタミンD"
    t.integer "vit_e", comment: "ビタミンE"
    t.integer "vit_k", comment: "ビタミンK"
    t.integer "vit_b1", comment: "ビタミンB1"
    t.integer "vit_b2", comment: "ビタミンB2"
    t.integer "vit_b6", comment: "ビタミンB6"
    t.integer "vit_b12"
    t.integer "vit_c", comment: "ビタミンC"
    t.integer "potassium", comment: "カリウム"
    t.integer "calcium", comment: "カルシウム"
    t.integer "magnesium", comment: "マグネシウム"
    t.integer "phosphorus", comment: "リン"
    t.integer "iron", comment: "鉄"
    t.integer "zinc", comment: "亜鉛"
    t.integer "copper", comment: "銅"
    t.integer "manganese", comment: "マンガン"
    t.integer "beta_carotene", comment: "βカロテン"
    t.integer "niacin", comment: "ナイアシン"
    t.integer "folic_acid", comment: "葉酸"
    t.integer "pantothenic_acid", comment: "パントテン酸"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rawmaterial_id"], name: "index_nutrients_on_rawmaterial_id"
  end

  create_table "procedureimages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "image", null: false, comment: "料理手順を示す画像"
    t.integer "order", null: false, comment: "料理手順画像を表示する順番"
    t.bigint "cuisine_id", comment: "料理id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_procedureimages_on_cuisine_id"
  end

  create_table "procedures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cooking_detail"
    t.bigint "cuisine_id", comment: "料理id"
    t.integer "row_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_procedures_on_cuisine_id"
  end

  create_table "rawmaterials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false, comment: "原材料名"
    t.string "hiragana"
    t.bigint "unit_id"
    t.bigint "foodcategory_id"
    t.integer "foodstuffs_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["foodcategory_id"], name: "index_rawmaterials_on_foodcategory_id"
    t.index ["name"], name: "index_rawmaterials_on_name", unique: true
    t.index ["unit_id"], name: "index_rawmaterials_on_unit_id"
  end

  create_table "stocks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "quantity", null: false
    t.bigint "rawmaterial_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rawmaterial_id"], name: "index_stocks_on_rawmaterial_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "taggings", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", collation: "utf8_bin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "todaysmenus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cuisine_id"
    t.bigint "user_id"
    t.integer "serving_count", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_todaysmenus_on_cuisine_id"
    t.index ["user_id"], name: "index_todaysmenus_on_user_id"
  end

  create_table "units", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nickname"
    t.string "email", default: "", null: false
    t.integer "default_serving_count", default: 1
    t.boolean "subscribed"
    t.datetime "subscribed_at"
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

  add_foreign_key "cuisines", "genres"
  add_foreign_key "favorites", "cuisines"
  add_foreign_key "favorites", "users"
  add_foreign_key "nutrients", "rawmaterials"
  add_foreign_key "procedureimages", "cuisines"
  add_foreign_key "rawmaterials", "units"
  add_foreign_key "stocks", "rawmaterials"
  add_foreign_key "stocks", "users"
  add_foreign_key "todaysmenus", "cuisines"
  add_foreign_key "todaysmenus", "users"
end
