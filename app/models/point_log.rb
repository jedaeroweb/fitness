class PointLog < ApplicationRecord
  belongs_to :branch
  validates_presence_of :point_id
end
