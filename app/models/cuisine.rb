class Cuisine < ApplicationRecord
  has_many :recipes

  validates :name, presence: {message: 'é campo obrigatório'}
  validates :name, uniqueness: {message: 'já existe'}
end
