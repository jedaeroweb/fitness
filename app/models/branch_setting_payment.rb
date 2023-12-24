class BranchSettingPayment < ApplicationRecord
  belongs_to :branch_setting
  belongs_to :payment
end
