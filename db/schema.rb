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

ActiveRecord::Schema.define(version: 2021_06_27_063323) do

  create_table "favorites", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_favorites_on_project_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "participants", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_admitted", default: false, null: false, comment: "プロジェクトに応募している or 参加している"
    t.index ["project_id"], name: "index_participants_on_project_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "projects", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description", comment: "プロジェクト概要"
    t.string "github_url", comment: "GitHubリポジトリURL"
    t.datetime "starts_at", comment: "開発期間：開始"
    t.datetime "ends_at", comment: "開発期間：終了"
    t.integer "recruitment_numbers", comment: "募集人数"
    t.string "tool_link", comment: "コミュニケーションツールのリンク"
    t.string "contribution", comment: "コントリビュート方法"
    t.text "languages", size: :long, collation: "utf8mb4_bin"
    t.index ["owner_id"], name: "index_projects_on_owner_id"
    t.check_constraint "json_valid(`languages`)", name: "languages"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid", null: false
    t.string "description", null: false
    t.string "github_id", null: false
    t.string "github_icon_url", null: false
    t.text "contribution_info", size: :long, null: false, collation: "utf8mb4_bin"
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.check_constraint "json_valid(`contribution_info`)", name: "contribution_info"
  end

  add_foreign_key "favorites", "projects"
  add_foreign_key "favorites", "users"
  add_foreign_key "participants", "projects"
  add_foreign_key "participants", "users"
  add_foreign_key "projects", "users", column: "owner_id"
end
