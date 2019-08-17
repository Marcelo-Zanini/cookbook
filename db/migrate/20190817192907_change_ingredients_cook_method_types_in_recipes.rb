class ChangeIngredientsCookMethodTypesInRecipes < ActiveRecord::Migration[5.2]
  def change
    change_column :recipes, :ingredients, :text
    change_column :recipes, :cook_method, :text
  end
end
