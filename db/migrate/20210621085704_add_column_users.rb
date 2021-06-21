# frozen_string_literal: true

class AddColumnUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :description, :string, null: false
    add_column :users, :github_id, :string, null: false
    add_column :users, :github_icon_url, :string, null: false
  end
end
