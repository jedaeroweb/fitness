class UserAdditional < ApplicationRecord
  belongs_to :user
  belongs_to :visit_route, counter_cache: true, optional: true
  belongs_to :job, counter_cache: true, optional: true

  validates_length_of :company, within: 1..60, allow_blank: true
end
