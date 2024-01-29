class ExerciseCategory < ApplicationRecord
  belongs_to :branch
  validates_presence_of :title
end
