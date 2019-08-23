require 'rails_helper'

feature 'User view owned recipes' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    other_user = User.create(email: 'gere@teste.com', password: '123456')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                          recipe_type: recipe_type, cuisine: cuisine,
                          user: user, cook_time: 50,
                          ingredients: 'Farinha, açucar, cenoura',
                          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other_recipe = Recipe.create(title: 'Bolo de laranja', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine,
                                user: user, cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a laranja, corte em pedaços pequenos, misture com o restante dos ingredientes')
    another_recipe = Recipe.create(title: 'Bolo de maçã',difficulty: 'Médio',
                                  recipe_type: recipe_type, cuisine: cuisine,
                                  user: other_user, cook_time: 50,
                                  ingredients: 'Farinha, açucar, cenoura',
                                  cook_method: 'Cozinhe a maçã, corte em pedaços pequenos, misture com o restante dos ingredientes')
    visit root_path
    click_on 'Entrar'
    #act
    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas Receitas'
    #assert
    expect(page).to have_css('.owner', text: "Receitas criadas por #{user.email}")
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).not_to have_content(another_recipe.title)
  end
  scenario 'and must be logged in' do
    #act
    visit root_path
    #assert
    expect(page).not_to have_link('Minhas Receitas')
  end

  scenario 'and must be logged in to access route' do
    #act
    visit my_recipes_path
    #assert
    expect(current_path).to eq new_user_session_path
  end
end
