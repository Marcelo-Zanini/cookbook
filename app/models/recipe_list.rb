class RecipeList < ApplicationRecord
  belongs_to :user

  validates :name, uniqueness: {case_sensitive: false,scope: :user , message: 'deve ser único'}
end
