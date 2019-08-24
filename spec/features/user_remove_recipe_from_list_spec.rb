require 'rails_helper'

feature 'User remove recipe from list' do
    scenario 'successfully' do
      #arrange
      user = User.create(email: 'marcelo@teste.com', password: '123456')
      recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                             recipe_type: recipe_type, cuisine: cuisine,
                             user: user, cook_time: 50,
                             ingredients: 'Farinha, açucar, cenoura',
                             cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      other_recipe = Recipe.create(title: 'Bolo de Bacalhau', difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  user: user, cook_time: 50,
                                  ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe o bacalhau, corte em pedaços pequenos, misture com o restante dos ingredientes')
      list_item = ListItem.create(recipe: recipe, recipe_list: recipe_list)
      other_list_item = ListItem.create(recipe: other_recipe, recipe_list: recipe_list)
      #act
      visit root_path
      click_on 'Entrar'

      within('.formulario') do
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
      end
      click_on 'Minhas Listas'
      click_on recipe_list.name
      within "#recipe#{other_recipe.id}" do
        click_on 'Remover'
      end
      expect(current_path).to eq recipe_list_path(recipe_list.id)
      expect(page).not_to have_content(other_recipe.title)
    end
end
