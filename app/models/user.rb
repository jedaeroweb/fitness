class User < ApplicationRecord
  after_initialize :default_values

  #devise :database_authenticatable, :registerable, :recoverable, :rememberable,  :validatable, :omniauthable, omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]
  validates_length_of :name, within: 1..60
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates_uniqueness_of :email, allow_blank: true
  validates_uniqueness_of :phone, allow_blank: true
  #validates_length_of :password, within: 5..255, allow_blank: true
  #validates_confirmation_of :password

  belongs_to :branch, counter_cache: true
  has_one :point, dependent: :destroy
  has_one :user_fc, dependent: :destroy
  has_one :user_trainer, dependent: :destroy
  has_one :user_admin, dependent: :destroy
  has_one :user_additional, dependent: :destroy
  has_one :user_picture, -> { order id: :desc }, dependent: :destroy
  has_one :user_group, dependent: :destroy
  has_one :user_unique_number, dependent: :destroy
  has_one :group, through: :user_group
  has_many :orders, dependent: :nullify
  has_many :accounts, dependent: :nullify
  has_many :user_contents, dependent: :destroy

  accepts_nested_attributes_for :user_fc, allow_destroy: true
  accepts_nested_attributes_for :user_trainer, allow_destroy: true
  accepts_nested_attributes_for :user_additional, allow_destroy: true
  accepts_nested_attributes_for :user_picture, allow_destroy: true, :reject_if => lambda { |c| c[:picture].blank? }
  accepts_nested_attributes_for :user_group, allow_destroy: true, :reject_if => lambda { |c| c[:group_id].blank? }
  accepts_nested_attributes_for :user_contents, allow_destroy: true, :reject_if => lambda { |c| c[:content].blank? }
  accepts_nested_attributes_for :user_unique_number, allow_destroy: true, :reject_if => lambda { |c| c[:unique_number].blank? }

  private

  def default_values
    self.registration_date ||= Date.today
  end
end
