class Instructor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :role, presence: true
end
