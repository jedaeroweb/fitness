class CreateAdminLoginLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_login_logs do |t|
      t.references :admin, null: false
      t.integer :client_ip, null: false, limit: 8
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
