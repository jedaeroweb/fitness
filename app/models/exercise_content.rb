class ExerciseContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :exercise, :foreign_key => :id, inverse_of: :exercise_content
end
