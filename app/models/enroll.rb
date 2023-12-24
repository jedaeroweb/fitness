class Enroll < ApplicationRecord
  validates_presence_of :order_id
  belongs_to :order

  has_many :order_products, through: :order
  has_one :enroll_trainer, dependent: :destroy

  accepts_nested_attributes_for :order
  accepts_nested_attributes_for :enroll_trainer, allow_destroy: true, :reject_if => lambda { |c| c[:admin_id].blank? }
end
