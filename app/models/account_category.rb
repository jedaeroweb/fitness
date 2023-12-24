class AccountCategory < ApplicationRecord
  validates_presence_of :title
  has_many :accounts, dependent: :destroy
end
