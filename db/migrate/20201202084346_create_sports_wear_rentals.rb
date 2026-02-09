class CreateSportsWearRentals < ActiveRecord::Migration[6.0]
  def change
    create_table :sports_wear_rentals do |t|
      t.references :order, null: false
      t.references :period_type, null: false, default: 1
      t.integer :quantity, null: false, default: 1
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
