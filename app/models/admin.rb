class Admin < ApplicationRecord
  after_initialize :default_values

  include OmniauthAttributesConcern
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :omniauthable, omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]
  #translates :name
  #
  validates_presence_of :email, :name
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates_uniqueness_of :email, allow_nil: true
  #validates_length_of :email, within: 4..100, allow_blank: true
  validates_length_of :name, within: 1..60

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

  def timeout_in
    1.day
  end

  private

  def default_values
    self.registration_date ||= Date.today
  end

  def email_required?
    false
  end

  #def password=(pass)
  #  if pass.present?
  #    @password = pass
  #    admin = Admin.new(login_id: login_id, password: pass)
  #    self.encrypted_password = admin.encrypted_password
  #  end
  #end
end
