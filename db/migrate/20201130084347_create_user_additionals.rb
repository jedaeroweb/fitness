class CreateUserAdditionals < ActiveRecord::Migration[6.0]
  def change
    create_table :user_additionals do |t|
      t.references :user, null: false
      t.references :job
      t.references :visit_route
      t.string :company, limit: 60
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
