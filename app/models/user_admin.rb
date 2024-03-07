class UserAdmin < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :admin
end
