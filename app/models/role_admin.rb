class RoleAdmin < ApplicationRecord
  belongs_to :role
  belongs_to :admin
end
