class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.references :branch, null: false
      t.references :user, null: false
      t.datetime :in_time, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
