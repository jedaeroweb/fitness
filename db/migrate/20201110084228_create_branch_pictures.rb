class CreateBranchPictures < ActiveRecord::Migration[6.0]
  def change
    create_table :branch_pictures do |t|
      t.references :branch, null: false
      t.string :picture, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
