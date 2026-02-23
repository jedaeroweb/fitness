class User < ApplicationRecord
  after_initialize :default_values

  include OmniauthAttributesConcern

  # Devise에서 validatable 제거
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :omniauthable,
         omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]

  # 이름 길이
  validates_length_of :name, within: 1..60

  # 이메일: 값이 있으면만 format/uniqueness 검사
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates_uniqueness_of :email, allow_nil: true

  # 전화번호: 값이 있으면만 유니크
  validates_uniqueness_of :phone, allow_blank: true

  # 비밀번호: 값이 있으면만 길이/confirmation 검사
  validates_length_of :password, within: 5..255, allow_blank: true
  validates_confirmation_of :password, allow_blank: true

  belongs_to :branch, counter_cache: true
  has_one :user_fc, dependent: :destroy
  has_one :user_trainer, dependent: :destroy
  has_one :user_admin, dependent: :destroy
  has_one :admin, through: :user_admin
  has_one :user_additional, dependent: :destroy
  has_one :user_picture, -> { order id: :desc }, dependent: :destroy
  has_one :user_group, dependent: :destroy
  has_one :user_unique_number, dependent: :destroy
  has_one :group, through: :user_group
  has_many :orders, dependent: :nullify
  has_many :accounts, dependent: :nullify
  has_many :user_contents, dependent: :destroy
  has_many :user_authentications, dependent: :destroy

  accepts_nested_attributes_for :user_fc, allow_destroy: true, :reject_if => lambda { |c| c[:picture].blank? }
  accepts_nested_attributes_for :user_trainer, allow_destroy: true, :reject_if => lambda { |c| c[:picture].blank? }
  accepts_nested_attributes_for :user_additional, allow_destroy: true, :reject_if => lambda { |c| c[:picture].blank? }
  accepts_nested_attributes_for :user_picture, allow_destroy: true, :reject_if => lambda { |c| c[:picture].blank? }
  accepts_nested_attributes_for :user_group, allow_destroy: true, :reject_if => lambda { |c| c[:group_id].blank? }
  accepts_nested_attributes_for :user_contents, allow_destroy: true, :reject_if => lambda { |c| c[:content].blank? }
  accepts_nested_attributes_for :user_unique_number, allow_destroy: true, :reject_if => lambda { |c| c[:unique_number].blank? }
  accepts_nested_attributes_for :user_authentications, allow_destroy: true

  def self.create_from_omniauth(params)
    self.__send__(params.provider, params)
  end

  def remember_me
    true
  end

  private

  def default_values
    self.registration_date ||= Date.today
  end
end
