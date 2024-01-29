class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.references :branch
      t.references :admin
      t.references :exercise_category, null: false
      t.string :title, limit: 60, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end

    create_table :exercise_contents do |t|
      t.text :content, null: false
    end
  end
end
