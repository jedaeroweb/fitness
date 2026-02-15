class CreateSportsWears < ActiveRecord::Migration[6.0]
  def change
    create_table :sports_wears do |t|
      t.references :product, null: false
      t.boolean :gender, null: false, default: true
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
