class CreateBranchSettingPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :branch_setting_payments do |t|
      t.references :branch_setting, null: false
      t.references :payment, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
