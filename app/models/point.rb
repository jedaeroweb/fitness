class Point < ApplicationRecord
  belongs_to :user
  has_many :point_logs, dependent: :destroy
end
