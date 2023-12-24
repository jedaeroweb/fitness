class Company < ApplicationRecord
  validates_presence_of :title
  has_many :branches
end
