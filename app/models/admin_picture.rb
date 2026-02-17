class AdminPicture < ApplicationRecord
  belongs_to :admin
  mount_uploader :picture, AdminPictureUploader
  mount_base64_uploader :picture, AdminPictureUploader
end
