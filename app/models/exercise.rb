class Exercise < ApplicationRecord
  is_impressionable
  validates_presence_of :title
  belongs_to :branch
  belongs_to :exercise_category
  belongs_to :admin, optional: true
  has_one :exercise_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :exercise
  has_one :exercise_picture, dependent: :destroy
  accepts_nested_attributes_for :exercise_content, :allow_destroy => true, :update_only => true
  accepts_nested_attributes_for :exercise_picture, allow_destroy: true
  def exercise_content
    super || build_exercise_content
  end
end
