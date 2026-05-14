class Category < ApplicationRecord
  has_many :recipes, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
