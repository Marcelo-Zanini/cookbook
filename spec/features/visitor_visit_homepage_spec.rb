require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'CookBook')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    recipe = create(:recipe)
    recipe.active!

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários

    recipe = create(:recipe, title: 'Bolo de Cenoura')
    another_recipe = create(:recipe, title: 'Bolinho de Bacalhau')
    recipe.active!
    another_recipe.active!

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_css('h3', text: another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end
end
