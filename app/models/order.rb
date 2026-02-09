class Order < ApplicationRecord
  after_initialize :default_values

  validates_presence_of :user_id, :total_price, :total_discount, :total_payment
  belongs_to :branch, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :account_orders, dependent: :nullify
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  has_many :accounts, through: :account_orders
  has_many :enrolls, dependent: :destroy
  has_many :locker_rentals, dependent: :destroy
  has_many :sports_wear_rentals, dependent: :destroy
  has_one :order_content, dependent: :destroy

  validates :order_products, presence: true
  accepts_nested_attributes_for :order_products, allow_destroy: true
  accepts_nested_attributes_for :accounts, allow_destroy: true
  accepts_nested_attributes_for :order_content, allow_destroy: true, :reject_if => lambda { |c| c[:content].blank? }

  private

  def default_values
    self.last_transaction_date ||= Date.today
  end
end
