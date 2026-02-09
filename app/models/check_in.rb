class CheckIn < ApplicationRecord
  validates_presence_of :branch_id, :user_id
  belongs_to :branch
  belongs_to :user

  def in_date(date)
    self.in_time = date
  end
end
