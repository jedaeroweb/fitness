class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.references :branch, null: false
      t.string :name, null: false, limit: 60
      t.date :birthday
      t.string :phone
      t.boolean :gender
      t.boolean :is_fc, null: false, default: 0
      t.boolean :is_trainer, null: false, default: 0
      t.float :commission_rate, null: false, default: 0
      t.date :registration_date, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
