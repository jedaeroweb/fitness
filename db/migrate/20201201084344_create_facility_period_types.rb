class CreateFacilityPeriodTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :facilty_period_types do |t|
      t.references :facility, null: false
      t.references :period_type, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
