class CreateProductCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_categories do |t|
      t.references :branch, null: false
      t.string :title, null: false
      t.integer :order_no, null: false, default: 0
      t.integer :products_count, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
