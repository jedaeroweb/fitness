class CreateUserTrainers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_trainers do |t|
      t.references :user, null: false
      t.references :admin, null: false
    end
  end
end
