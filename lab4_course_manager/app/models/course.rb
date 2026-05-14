class Course < ApplicationRecord
  enum :status, { planned: 0, active: 1, completed: 2, cancelled: 3 }

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :client, presence: true
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?
    return if end_date > start_date

    errors.add(:end_date, "must be after start date")
  end
end
