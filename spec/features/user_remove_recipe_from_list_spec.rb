require 'rails_helper'
FactoryBot.find_definitions

feature 'User remove recipe from list' do
    scenario 'successfully' do
      #arrange
      user = create(:user)
      recipe_list = create(:recipe_list, user: user, name: 'Gostosuras')
      list_item = create(:list_item, recipe_list: recipe_list)
      other_list_item = create(:list_item, recipe_list: recipe_list)
      #act
      login_as(user, scope: :user)
      visit root_path

      click_on 'Minhas Listas'
      click_on recipe_list.name
      within "#recipe#{list_item.recipe.id}" do
        click_on 'Remover'
      end
      expect(current_path).to eq recipe_list_path(recipe_list.id)
      expect(page).not_to have_content(list_item.recipe.title)
    end
end
