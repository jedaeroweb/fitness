class ProductCategory < ApplicationRecord
  validates_presence_of :title
  belongs_to :branch, counter_cache: true
  has_many :products, dependent: :destroy
end
