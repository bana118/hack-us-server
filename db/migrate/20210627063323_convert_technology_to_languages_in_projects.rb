# frozen_string_literal: true

class ConvertTechnologyToLanguagesInProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :technology1, :string
    remove_column :projects, :technology2, :string
    remove_column :projects, :technology3, :string
    remove_column :projects, :technology4, :string
    remove_column :projects, :technology5, :string
    add_column :projects, :languages, :json
  end
end
