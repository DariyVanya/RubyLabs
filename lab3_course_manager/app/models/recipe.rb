class Recipe < ApplicationRecord
  enum :difficulty, { easy: 0, medium: 1, hard: 2 }

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :cooking_time, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
  validates :servings, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
