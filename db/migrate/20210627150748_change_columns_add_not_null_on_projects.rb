# frozen_string_literal: true

class ChangeColumnsAddNotNullOnProjects < ActiveRecord::Migration[6.1]
  def change
    change_column_null :projects, :name, false
    change_column_null :projects, :description, false
    change_column_null :projects, :github_url, false
    change_column_null :projects, :recruitment_numbers, false
    change_column_null :projects, :tool_link, false
    change_column_null :projects, :contribution, false
    change_column_null :projects, :languages, false
  end
end
