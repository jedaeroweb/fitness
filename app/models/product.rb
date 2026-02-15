class Product < ApplicationRecord
  validates_presence_of :title, :price
  validates :order_no, numericality: { only_integer: true }, allow_nil: true
  belongs_to :branch, counter_cache: true
  belongs_to :product_category, counter_cache: true, :optional => true
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :account_products, dependent: :nullify
  has_one :product_picture, dependent: :destroy
  has_one :product_content, dependent: :destroy
  has_one :course, dependent: :destroy
  has_one :locker, dependent: :destroy
  accepts_nested_attributes_for :product_picture, allow_destroy: true
  accepts_nested_attributes_for :product_content, allow_destroy: true, :reject_if => lambda { |c| c[:content].blank? }
end
