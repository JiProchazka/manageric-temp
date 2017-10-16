class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :client, null: false
      t.string :info

      t.timestamps
    end
  end
end
