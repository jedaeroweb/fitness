class CreateAccountOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :account_orders do |t|
      t.references :account, null: false
      t.references :order
      t.boolean :enable, null: false, default: true
    end
  end
end
