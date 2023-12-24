class CreateOrderContents < ActiveRecord::Migration[6.0]
  def change
    create_table :order_contents do |t|
      t.references :order, null: false
      t.text :content, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
