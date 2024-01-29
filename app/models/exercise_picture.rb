class ExercisePicture < ApplicationRecord
  belongs_to :exercise, autosave: true
  mount_uploader :picture, ExercisePictureUploader
end
