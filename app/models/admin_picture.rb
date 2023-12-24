class AdminPicture < ApplicationRecord
  belongs_to :admin, autosave: true
  mount_uploader :picture, AdminPictureUploader
  mount_base64_uploader :picture, AdminPictureUploader
end
