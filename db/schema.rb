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

ActiveRecord::Schema.define(version: 2021_07_01_232420) do

  create_table "contributions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "language", null: false
    t.string "color", null: false
    t.integer "count", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "favorites", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_favorites_on_project_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "languages", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "name", null: false
    t.string "color", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_languages_on_project_id"
  end

  create_table "participants", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "user_approved", comment: "false: ???????????????, true: ???????????????"
    t.boolean "owner_approved", comment: "false: ???????????????, true: ???????????????"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "projects", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description", null: false, comment: "????????????????????????"
    t.string "github_url", null: false, comment: "GitHub???????????????URL"
    t.datetime "starts_at", comment: "?????????????????????"
    t.datetime "ends_at", comment: "?????????????????????"
    t.integer "recruitment_numbers", comment: "????????????"
    t.string "tool_link", null: false, comment: "????????????????????????????????????????????????"
    t.string "contribution", null: false, comment: "??????????????????????????????"
    t.string "owner_uid", null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid", null: false
    t.string "description", null: false
    t.string "github_id", null: false
    t.string "github_icon_url", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "contributions", "users"
  add_foreign_key "favorites", "projects"
  add_foreign_key "favorites", "users"
  add_foreign_key "languages", "projects"
  add_foreign_key "participants", "projects"
  add_foreign_key "participants", "users"
end
