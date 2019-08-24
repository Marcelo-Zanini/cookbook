require 'rails_helper'

feature 'User add recipe to list' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on recipe.title
    select recipe_list.name, from: 'Minhas Listas'
    click_on 'Adicionar à Lista'
    #assert
    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content('Adicionado à lista com Sucesso')

  end
  scenario 'and must be unique in the list' do
    #arrange
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    list_item = ListItem.create(recipe: recipe, recipe_list: recipe_list)
    #act
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on recipe.title
    select recipe_list.name, from: 'Minhas Listas'
    click_on 'Adicionar à Lista'
    #assert
    expect(current_path).to eq recipe_path(recipe)
    expect(page).not_to have_content('Adicionado à lista com Sucesso')
    expect(page).to have_content('Recipe já existe na lista')
  end
end
