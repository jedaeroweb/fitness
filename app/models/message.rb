class Message < ApplicationRecord
  validates_presence_of :branch_id, :title
  belongs_to :branch
  belongs_to :message_send_type
  has_many :message_receivers, dependent: :destroy
  has_one :message_senders, dependent: :destroy
  has_one :message_content, :foreign_key => :id, :dependent => :destroy, inverse_of: :message
  accepts_nested_attributes_for :message_content, :allow_destroy => true, :update_only => true

  def message_content
    super || build_message_content
  end
end
