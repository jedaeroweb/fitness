class CreatePreparedMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :prepared_messages do |t|
      t.references :branch, null: false
      t.string :title, null: false, limit: 60
      t.integer :messages_count, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    create_table :prepared_message_contents do |t|
      t.text :content, null: false
    end
  end
end
