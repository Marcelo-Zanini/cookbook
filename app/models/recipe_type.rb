class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: true
  validates :name, uniqueness: {case_sensitive: false}
end
