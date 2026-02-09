class LockerRental < ApplicationRecord
  validates_presence_of :order_id
  belongs_to :order

  has_many :order_products, through: :order

  accepts_nested_attributes_for :order
  accepts_nested_attributes_for :order_products, allow_destroy: true
end
