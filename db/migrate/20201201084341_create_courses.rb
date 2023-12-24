class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :product, null: false
      t.integer :order_no, null: false, default: 1
      t.integer :default_quantity, null: false, default: 1
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
