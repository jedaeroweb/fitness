class CreateEnrollTrainers < ActiveRecord::Migration[6.0]
  def change
    create_table :enroll_trainers do |t|
      t.references :enroll, null: false
      t.references :admin, null: false
    end
  end
end
