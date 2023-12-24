class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: false
      t.references :product, null: false
      t.integer :price, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.boolean :enable, null: false, default: true
    end
  end
end
