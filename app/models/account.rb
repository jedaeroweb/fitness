class Account < ApplicationRecord
  before_save :default_values
  belongs_to :account_category, counter_cache: true
  belongs_to :branch, counter_cache: true
  belongs_to :user, counter_cache: true
  has_many :account_orders, dependent: :destroy
  has_many :account_products, dependent: :destroy
  has_many :account_payments, dependent: :destroy
  has_many :orders, through: :account_orders
  has_many :products, through: :account_products
  has_many :payments, through: :account_payments

  private

  def default_values
    self.transaction_date ||= Date.today
  end
end
