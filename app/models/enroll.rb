class Enroll < ApplicationRecord
  validates_presence_of :order_id
  belongs_to :order

  has_many :order_products, through: :order
  has_one :enroll_trainer, dependent: :destroy

  accepts_nested_attributes_for :order
  accepts_nested_attributes_for :enroll_trainer,
                                allow_destroy: true,
                                reject_if: ->(c) { c[:admin_id].blank? }

  # 👇 여기 추가
  validates :start_date, :end_date, presence: true
  validate :start_date_before_end_date

  private

  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      errors.add(:base, "날짜 형식이 올바르지 않습니다.")
      return
    end

    if start_date > end_date
      errors.add(:start_date, "는 종료일보다 빨라야 합니다.")
    end
  end
end