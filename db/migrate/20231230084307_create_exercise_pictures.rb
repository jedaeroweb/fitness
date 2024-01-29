class CreateExercisePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_pictures do |t|
      t.references :exercise, null: false
      t.string :picture, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
