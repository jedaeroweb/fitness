class CreateUserUniqueNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_unique_numbers do |t|
      t.references :user, null: false
      t.string :unique_number, null: false, limit: 60
    end
  end
end
