class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.references :branch, null: false
      t.string :title, null: false, limit: 60
      t.string :description, limit: 250
      t.integer :users_count, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    add_index :groups, [:branch_id, :title], :unique => true
  end
end
