class CreateUserDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :user_devices do |t|
      t.references :user, null: false
      t.string :os, null: false, default: 'android'
      t.string :token, null: false, limit: 150
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
