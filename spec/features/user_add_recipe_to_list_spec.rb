require 'rails_helper'
FactoryBot.find_definitions

feature 'User add recipe to list' do
  scenario 'successfully' do
    #arrange
    user = create(:user, email: 'user@mail.com')
    recipe_list = create(:recipe_list, user: user)
    recipe = create(:recipe)
    recipe.active!
    #act
    login_as(user, scope: :user)
    visit root_path

    click_on recipe.title
    select recipe_list.name, from: 'Minhas Listas'
    click_on 'Adicionar à Lista'
    #assert
    expect(current_path).to eq recipe_path(recipe)
    expect(page).to have_content('Adicionado à lista com Sucesso')

  end
  scenario 'and must be unique in the list' do
    #arrange
    user = create(:user, email: 'user@mail.com')
    recipe_list = create(:recipe_list, user: user)
    recipe = create(:recipe)
    recipe.active!
    list_item = create(:list_item, recipe: recipe, recipe_list: recipe_list)
    #act
    login_as(user, scope: :user)
    visit root_path

    click_on recipe.title
    select recipe_list.name, from: 'Minhas Listas'
    click_on 'Adicionar à Lista'
    #assert
    expect(current_path).to eq recipe_path(recipe)
    expect(page).not_to have_content('Adicionado à lista com Sucesso')
    expect(page).to have_content('Recipe já existe na lista')
  end
end
