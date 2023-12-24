class CreateMessageResults < ActiveRecord::Migration[6.0]
  def change
    create_table :message_results do |t|
      t.references :message, null: false
      t.integer :result_code, null: false
      t.string :result_message, null: false
      t.integer :msg_id, null: false
      t.string :msg_type, null: false
      t.integer :success_cnt, null: false, default: 0
      t.integer :error_cnt, null: false, default: 0
      t.boolean :enable, null: false, default: true
    end
  end
end
