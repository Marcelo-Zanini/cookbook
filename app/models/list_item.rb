class ListItem < ApplicationRecord
  belongs_to :recipe_list
  belongs_to :recipe
end
