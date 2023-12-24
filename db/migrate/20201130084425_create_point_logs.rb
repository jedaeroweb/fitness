class CreatePointLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :point_logs do |t|
      t.references :point, null: false
      t.integer :charge, null: false, default: 0
      t.string :refund, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
