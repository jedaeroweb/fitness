class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups do |t|
      t.references :user, null: false
      t.references :group, null: false
    end
  end
end
