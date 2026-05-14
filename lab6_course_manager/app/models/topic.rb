class Topic < ApplicationRecord
  has_many :course_topics, dependent: :destroy
  has_many :courses, through: :course_topics

  validates :name, presence: true, uniqueness: true
end
