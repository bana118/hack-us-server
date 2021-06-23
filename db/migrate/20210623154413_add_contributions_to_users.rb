class AddContributionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :contribution_info, :json, null: false
  end
end
