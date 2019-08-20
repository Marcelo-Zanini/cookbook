class RecipeType < ApplicationRecord
  has_many :recipes

  validates :name, presence: {message: 'é campo obrigatório'}
  validates :name, uniqueness: {message: 'já existe', case_sensitive: false}
end
