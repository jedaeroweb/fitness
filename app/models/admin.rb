class Admin < ApplicationRecord
  after_initialize :default_values
  validates_length_of :name, within: 1..60

  devise :database_authenticatable

  belongs_to :branch, counter_cache: true
  has_one :admin_picture, dependent: :destroy
  has_one :role_admin
  has_one :role, through: :role_admin
  has_many :admin_login_log, dependent: :destroy
  has_many :admin_contents, dependent: :destroy

  accepts_nested_attributes_for :role_admin, :allow_destroy => true
  accepts_nested_attributes_for :admin_picture, :allow_destroy => true
  accepts_nested_attributes_for :admin_contents, :allow_destroy => true

  def role?(role)
    if self.role.role==role.to_s
      return true
    else
      return false
    end
  end

  private

  def default_values
    self.registration_date ||= Date.today
  end
end
