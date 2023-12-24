class CounselContent < ApplicationRecord
  validates_presence_of :content
  belongs_to :counsel, :foreign_key => :id, inverse_of: :counsel_content
end
