class ChangeOwnerIdToOwnerUidInProjects < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :owner_id, :big_int
    add_column :projects, :owner_uid, :string, null: false
  end
end
