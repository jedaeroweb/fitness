class PointLog < ApplicationRecord
  validates_presence_of :point_id
  belongs_to :point, counter_cache: true
end
