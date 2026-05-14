class CourseTopic < ApplicationRecord
  belongs_to :course
  belongs_to :topic
end
