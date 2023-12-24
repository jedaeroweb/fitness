class Group < ApplicationRecord
  validates_presence_of :title
  belongs_to :branch
  has_many :user_groups
  has_many :users, through: :user_groups, autosave: true
end
