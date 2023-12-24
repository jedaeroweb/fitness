class PeriodType < ApplicationRecord
  has_many :courses
  has_many :facilities
end
