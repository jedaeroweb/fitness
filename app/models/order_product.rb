class OrderProduct < ApplicationRecord
  validates_presence_of :product_id
  belongs_to :order, autosave: true
  belongs_to :product, autosave: true
end
