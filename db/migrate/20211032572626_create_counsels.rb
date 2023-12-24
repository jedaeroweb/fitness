class CreateCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :counsels do |t|
      t.references :branch, null: false
      t.references :admin
      t.string :title, null: false, limit: 60
      t.date :registered_date, null: false
      t.boolean :complete, null: false, default: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    create_table :counsel_contents do |t|
      t.text :content, null: false
    end
  end
end
