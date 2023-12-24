class CreateMessageReceivers < ActiveRecord::Migration[6.0]
  def change
    create_table :message_receivers do |t|
      t.references :message, null: false
      t.references :user, null: false
      t.boolean :enable, null: false, default: true
    end
  end
end
