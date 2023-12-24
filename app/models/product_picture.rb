class ProductPicture < ApplicationRecord
  belongs_to :product, autosave: true
  mount_uploader :picture, ProductPictureUploader
end
