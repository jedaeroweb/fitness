class AccountPayment < ApplicationRecord
  validates_presence_of :account_id, :payment_id
  belongs_to :account, autosave: true
  belongs_to :payment, autosave: true
end
