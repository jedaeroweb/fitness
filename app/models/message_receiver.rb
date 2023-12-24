class MessageReceiver < ApplicationRecord
  validates_presence_of :message_id, :user_id
  belongs_to :message
  belongs_to :user
end
