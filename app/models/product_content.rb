class ProductContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :product
end
