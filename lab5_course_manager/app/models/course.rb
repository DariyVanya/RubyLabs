class Course < ApplicationRecord
  enum :status, { draft: 0, active: 1, archived: 2 }

  has_many :instructors, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true
  validates :duration_hours, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date

  scope :starting_soon, -> { where(start_date: Date.current..Date.current + 30.days) }
  scope :draft, -> { where(status: :draft) }
  scope :active, -> { where(status: :active) }
  scope :free, -> { where(price: 0) }

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    return if end_date > start_date

    errors.add(:end_date, "must be after start date")
  end
end
