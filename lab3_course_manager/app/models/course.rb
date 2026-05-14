class Course < ApplicationRecord
  enum :status, { draft: 0, active: 1, archived: 2 }

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :duration_hours, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    return if end_date > start_date

    errors.add(:end_date, "must be after start date")
  end
end
