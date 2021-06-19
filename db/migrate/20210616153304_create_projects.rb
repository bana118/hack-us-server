class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, forein_key: true
      t.string :name

      t.timestamps
    end
  end
end
