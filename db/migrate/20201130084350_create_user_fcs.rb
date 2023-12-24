class CreateUserFcs < ActiveRecord::Migration[6.0]
  def change
    create_table :user_fcs do |t|
      t.references :user, null: false
      t.references :admin, null: false
    end
  end
end
