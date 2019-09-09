require 'rails_helper'
FactoryBot.find_definitions

feature 'User update recipe' do
  scenario 'successfully' do
    #arrange
    user = create(:user)
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe = create(:recipe, title: 'Bolodecenoura', user: user,
                    cuisine: cuisine, recipe_type: recipe_type)
    recipe.active!
    create(:recipe_type, name: 'Entrada')
    create(:cuisine, name: 'Arabe')
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Entrada', from: 'Tipo de Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Método de Preparo', with: 'Faça um bolo e uma cobertura de chocolate'

    click_on 'Enviar'
    #assert
    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Médio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
  end

  scenario 'and must fill in all fields' do
    #arrange
    user = create(:user)
    recipe = create(:recipe, title: 'Bolodecenoura',user: user)
    recipe.active!
    # act
    login_as(user, scope: :user)
    visit root_path

    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Método de Preparo', with: ''
    click_on 'Enviar'
    #assert
    expect(page).to have_content('Não foi possível salvar a receita')
  end

  scenario 'And must be logged in' do
    #arrange
    recipe = create(:recipe, title: 'Bolo de Cenoura')
    recipe.active!
    #act
    visit root_path
    click_on 'Bolo de Cenoura'
    #assert
    expect(page).not_to have_link('Editar')
  end
  scenario 'and must be recipe owner' do
    #arrange
    user =create(:user, email: 'marcelo@teste.com')
    other_user = create(:user, email: 'gere@teste.com')
    recipe = create(:recipe, title: 'Bolodecenoura', user: other_user)
    #act
    login_as(user, scope: :user)
    visit root_path
    visit edit_recipe_path(recipe.id)
    #assert
    expect(current_path).to eq root_path
  end
end
