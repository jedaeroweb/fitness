class PreparedMessage < ApplicationRecord
  validates_presence_of :branch_id, :title
  belongs_to :branch
  has_one :prepared_message_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :prepared_message
  accepts_nested_attributes_for :prepared_message_content, :allow_destroy => true, :update_only => true

  def prepared_message_content
    super || build_prepared_message_content
  end
end
