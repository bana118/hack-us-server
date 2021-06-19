class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.bigint :owner_id, index: true
      t.string :name

      t.timestamps
    end
    add_foreign_key :projects, :users, column: :owner_id
  end
end
