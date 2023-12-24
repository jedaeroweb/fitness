class CreateBranches < ActiveRecord::Migration[6.0]
  def change
    create_table :branches do |t|
      t.references :company, null: false
      t.string :title, null: false, limit: 60
      t.integer :sample, null: false, default: 0
      t.integer :admins_count, null: false, default: 0
      t.integer :users_count, null: false, default: 0
      t.integer :product_categories_count, null: false, default: 0
      t.integer :products_count, null: false, default: 0
      t.integer :orders_count, null: false, default: 0
      t.integer :accounts_count, null: false, default: 0
      t.string :locale, null: false, limit: 10, default: I18n.default_locale
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
