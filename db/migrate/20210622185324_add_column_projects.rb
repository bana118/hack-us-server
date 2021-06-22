# frozen_string_literal: true

class AddColumnProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :description, :string, null: true, comment: "プロジェクト概要"
    add_column :projects, :github_url, :string, null: true, comment: "GitHubリポジトリURL"
    add_column :projects, :starts_at, :datetime, null: true, comment: "開発期間：開始"
    add_column :projects, :ends_at, :datetime, null: true, comment: "開発期間：終了"
    add_column :projects, :technology1, :string, null: true, comment: "使用技術1"
    add_column :projects, :technology2, :string, null: true, comment: "使用技術2"
    add_column :projects, :technology3, :string, null: true, comment: "使用技術3"
    add_column :projects, :technology4, :string, null: true, comment: "使用技術4"
    add_column :projects, :technology5, :string, null: true, comment: "使用技術5"
    add_column :projects, :recruitment_numbers, :integer, null: true, comment: "募集人数"
    add_column :projects, :tool_link, :string, null: true, comment: "コミュニケーションツールのリンク"
    add_column :projects, :contribution, :string, null: true, comment: "コントリビュート方法"
  end
end
