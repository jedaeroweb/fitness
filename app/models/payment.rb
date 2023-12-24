class Payment < ApplicationRecord
  has_many :branches_payments
  has_many :accounts_products
  has_many :accounts, :through => :accounts_products
end
