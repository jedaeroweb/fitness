class CreateMessageSenders < ActiveRecord::Migration[6.0]
  def change
    create_table :message_senders do |t|
      t.references :message, null: false
      t.references :admin, null: false
      t.boolean :enable, null: false, default: true
    end
  end
end
