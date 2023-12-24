class MessageContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :message, :foreign_key => :id, inverse_of: :message_content
end
