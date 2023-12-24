class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :branch, null: false
      t.references :account_category, null: false
      t.references :user
      t.date :transaction_date, null: false
      t.integer :income, null: false, default: 1
      t.integer :account, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
