class ListItem < ApplicationRecord
  belongs_to :recipe_list
  belongs_to :recipe

  validates :recipe, uniqueness:{scope: :recipe_list, message: 'já existe na lista'}
end
