class Job < ApplicationRecord
  validates_presence_of :title
  has_one :user_additional
end
