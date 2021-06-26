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

ActiveRecord::Schema.define(version: 2021_06_26_123031) do

  create_table "favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_favorites_on_project_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "participants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admitted", default: false, null: false, comment: "プロジェクトに応募している or 参加している"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "projects", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description", comment: "プロジェクト概要"
    t.string "github_url", comment: "GitHubリポジトリURL"
    t.datetime "starts_at", comment: "開発期間：開始"
    t.datetime "ends_at", comment: "開発期間：終了"
    t.string "technology1", comment: "使用技術1"
    t.string "technology2", comment: "使用技術2"
    t.string "technology3", comment: "使用技術3"
    t.string "technology4", comment: "使用技術4"
    t.string "technology5", comment: "使用技術5"
    t.integer "recruitment_numbers", comment: "募集人数"
    t.string "tool_link", comment: "コミュニケーションツールのリンク"
    t.string "contribution", comment: "コントリビュート方法"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid", null: false
    t.string "description", null: false
    t.string "github_id", null: false
    t.string "github_icon_url", null: false
    t.json "contribution_info", null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "favorites", "projects"
  add_foreign_key "favorites", "users"
  add_foreign_key "participants", "projects"
  add_foreign_key "participants", "users"
  add_foreign_key "projects", "users", column: "owner_id"
end
