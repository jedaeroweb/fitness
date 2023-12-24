class CreateAccountProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :account_products do |t|
      t.references :account, null: false
      t.references :product
      t.boolean :enable, null: false, default: true
    end
  end
end
