class BranchSetting < ApplicationRecord
  belongs_to :branch
  has_many :branch_setting_payments
  validates :branch_setting_payments, presence: true

  accepts_nested_attributes_for :branch_setting_payments, allow_destroy: true
end
