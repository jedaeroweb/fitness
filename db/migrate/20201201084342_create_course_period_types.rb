class CreateCoursePeriodTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :course_period_types do |t|
      t.references :course, null: false
      t.references :period_type, null: false
      t.boolean :enable, null: false, default: true
      t.timestamps null: false
    end
  end
end
