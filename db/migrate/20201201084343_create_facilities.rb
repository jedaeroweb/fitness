class CreateFacilities < ActiveRecord::Migration[6.0]
  def change
    create_table :facilities do |t|
      t.references :product, null: false
      t.integer :order_no, null: false, default: 1
      t.integer :quantity, null: false, default: true
      t.integer :start_no, null: false, default: true
      t.boolean :gender, null: false, default: true
      t.boolean :use_not_set, null: false, default: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
