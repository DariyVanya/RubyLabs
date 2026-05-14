class Photo < ApplicationRecord
  belongs_to :recipe

  validates :caption, :url, presence: true
end
