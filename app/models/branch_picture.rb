class BranchPicture < ApplicationRecord
  belongs_to :branch, autosave: true
  mount_uploader :picture, BranchPictureUploader
end
