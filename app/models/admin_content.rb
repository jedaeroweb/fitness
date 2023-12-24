class AdminContent < ApplicationRecord
  validates_presence_of :content, allow_blank: true
  belongs_to :admin
end
