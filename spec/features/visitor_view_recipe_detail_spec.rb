require 'rails_helper'
FactoryBot.find_definitions

feature 'Visitor view recipe details' do
  scenario 'successfully' do
    #cria os dados necessários

    recipe = create(:recipe)
    recipe.active!

    # simula a ação do usuário
    visit root_path
    click_on recipe.title

    # expectativas do usuário após a ação
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: recipe.recipe_type.name)
    #expect(page).to have_css('p', text: recipe.cuisine.name)
    expect(page).to have_css('p', text: recipe.difficulty)
    expect(page).to have_css('p', text: "#{recipe.cook_time} minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: recipe.ingredients)
    expect(page).to have_css('h3', text: 'Método de Preparo')
    expect(page).to have_css('p', text: recipe.cook_method)
  end

  scenario 'and return to recipe list' do
    #cria os dados necessários
    recipe = create(:recipe)
    recipe.active!
    # simula a ação do usuário
    visit root_path
    click_on recipe.title
    click_on 'CookBook'

    # expectativa da rota atual
    expect(current_path).to eq(root_path)
  end
end
