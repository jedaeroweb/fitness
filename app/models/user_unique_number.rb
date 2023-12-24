class UserUniqueNumber < ApplicationRecord
  belongs_to :user

  validates_presence_of :unique_number
end
