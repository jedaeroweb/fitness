class CreateRoleAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :role_admins do |t|
      t.references :role, null: false
      t.references :admin, null: false
    end
  end
end
