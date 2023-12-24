class MessageSender < ApplicationRecord
  validates_presence_of :message_id, :admin_id
  belongs_to :message
  belongs_to :admin
end
