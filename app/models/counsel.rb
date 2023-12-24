class Counsel < ApplicationRecord
  validates_presence_of :title, :registered_date
  belongs_to :branch
  belongs_to :admin, :optional => true
  has_one :counsel_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :counsel
  accepts_nested_attributes_for :counsel_content, :allow_destroy => true, :update_only => true

  def counsel_content
    super || build_counsel_content
  end
end
