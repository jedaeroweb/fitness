class TempUser < ApplicationRecord
  validates_length_of :name, within: 2..50
  belongs_to :branch, counter_cache: true
end
