class Facility < ApplicationRecord
  belongs_to :product
  accepts_nested_attributes_for :product
end
