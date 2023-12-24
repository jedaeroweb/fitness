class UserPicture < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, UserPictureUploader
  mount_base64_uploader :picture, UserPictureUploader
end
