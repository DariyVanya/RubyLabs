class Instructor < ApplicationRecord
  belongs_to :course, optional: true

  validates :name, presence: true
  validates :role, presence: true
end
