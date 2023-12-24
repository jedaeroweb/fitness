class ProductCategoryPicture < ApplicationRecord
  validates_presence_of :product_category_id
  belongs_to :product_category, autosave: true, counter_cache: true
  mount_uploader :picture, ProductCategoryPictureUploader
end
