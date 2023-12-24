class PreparedMessageContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :prepared_message, :foreign_key => :id, inverse_of: :prepared_message_content
end
