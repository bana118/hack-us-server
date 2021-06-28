class ConvertJsonColumnToAnotherTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :languages, :json
    remove_column :users, :contribution_info, :json
    create_table :contributions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :language, null: false
      t.string :color, null: false
      t.integer :count, null: false
      t.timestamps
    end
    create_table :languages do |t|
      t.references :project, null: false, foreign_key: true

      t.string :name, null: false
      t.string :color, null: false
      t.timestamps
    end
  end
end
