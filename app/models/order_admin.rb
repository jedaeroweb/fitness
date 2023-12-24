class OrderAdmin < ApplicationRecord
  validates_presence_of :order_id, :admin_id
  belongs_to :order, autosave: true
  belongs_to :admin, autosave: true
end
