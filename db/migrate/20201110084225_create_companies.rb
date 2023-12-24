class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :title, null: false, limit: 60
      t.integer :branches_count, null: false, default: 0
      t.boolean :premium, null: false, default: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
