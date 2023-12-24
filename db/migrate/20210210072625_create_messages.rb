class CreateMessages< ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :branch, null: false
      t.references :message_send_type, null: false, default:1
      t.string :title, null: false, limit: 60
      t.integer :send_all, null: false, default: 0
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    create_table :message_contents do |t|
      t.text :content, null: false
    end
  end
end
