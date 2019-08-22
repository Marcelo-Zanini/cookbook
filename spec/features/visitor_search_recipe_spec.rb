require 'rails_helper'

feature 'Visitor search recipe' do
  scenario 'by full title succesfully' do
    #arranje
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_cuisine = Cuisine.create(name: 'Australiana')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    another_recipe = Recipe.create(title: 'Bolo de pote',
                                   recipe_type: another_recipe_type,
                                   cuisine: another_cuisine,
                                   difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes')
    # act
    visit root_path
    fill_in 'Busca', with: recipe.title
    click_on 'Buscar'
    #assert
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_content(another_recipe.title)
  end
  scenario 'by full title with no results' do
    #arranje
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_cuisine = Cuisine.create(name: 'Australiana')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    another_recipe = Recipe.create(title: 'Bolo de pote',
                                   recipe_type: another_recipe_type,
                                   cuisine: another_cuisine,
                                   difficulty: 'Difícil',
                                   user: user, cook_time: 50,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes')
    # act
    visit root_path
    fill_in 'Busca', with: 'Bolo de fubá'
    click_on 'Buscar'
    #assert
    expect(page).not_to have_content(recipe.title)
    expect(page).not_to have_content(another_recipe.title)
    expect(page).to have_content('Receita não encontrada')
  end
  scenario 'by partial title with some results' do
    #arranje
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    another_recipe_type = RecipeType.create(name: 'Prato principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    another_cuisine = Cuisine.create(name: 'Australiana')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    another_recipe = Recipe.create(title: 'Bolo de pote',
                                   recipe_type: another_recipe_type,
                                   cuisine: another_cuisine,
                                   difficulty: 'Difícil',
                                   user: user, cook_time: 50,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes')
     third_recipe = Recipe.create(title: 'Risoto',
                                    recipe_type: another_recipe_type,
                                    cuisine: another_cuisine,
                                    difficulty: 'Difícil',
                                    user: user, cook_time: 50,
                                    ingredients: 'Feijão e carnes',
                                    cook_method: 'Misture o feijão com as carnes')
    # act
    visit root_path
    fill_in 'Busca', with: 'Bolo'
    click_on 'Buscar'
    #assert
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h1', text: another_recipe.title)
    expect(page).not_to have_content(third_recipe.title)
  end
end
