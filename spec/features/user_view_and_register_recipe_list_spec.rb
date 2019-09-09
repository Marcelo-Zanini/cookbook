require 'rails_helper'

feature 'User view and register recipe list' do
  scenario 'successfully' do
    #arrange
    user = create(:user)
    #act
    login_as(user, scope: :user)
    visit root_path

    click_on 'Minhas Listas'
    click_on 'Nova Lista'
    fill_in 'Nome', with: 'Gostosuras ou Travessuras'
    click_on 'Enviar'
    #assert
    expect(page).to have_css('h3',text:'Gostosuras ou Travessuras')
    expect(page).to have_css('h4',text:'Esta lista ainda esta vazia')
  end

  scenario 'only view lists' do
    #arrange
    user = create(:user)
    recipe_list = create(:recipe_list, user: user, name: 'Gostosuras')
    another_recipe_list = create(:recipe_list, user: user, name: 'Gordices')
    other_user = create(:user)
    other_recipe_list = create(:recipe_list, user: other_user, name: 'Travessuras')
    #act
    login_as(user, scope: :user)
    visit root_path

    click_on 'Minhas Listas'
    #assert
    expect(page).to have_css('h3',text: recipe_list.name)
    expect(page).to have_css('h3',text: another_recipe_list.name)
    expect(page).not_to have_content(other_recipe_list.name)

  end

  scenario 'and must have unique name ' do
    #arrange
    user = create(:user)
    recipe_list = create(:recipe_list, user: user, name: 'Gostosuras')
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Listas'
    click_on 'Nova Lista'
    fill_in 'Nome', with: recipe_list.name
    click_on 'Enviar'
    #assert
    expect(page).not_to have_content(recipe_list.name)
    expect(page).to have_content('Não foi possível criar lista')
    expect(page).to have_content('Nome já está em uso')
  end
  scenario 'and must have unique name only for same user' do
    #arrange
    user = create(:user)
    recipe_list = create(:recipe_list, user: user, name: 'Gostosuras')
    other_user = create(:user)
    other_recipe_list = create(:recipe_list, user: other_user, name: 'Travessuras')
    #act
    login_as(user, scope: :user)
    visit root_path

    click_on 'Minhas Listas'
    click_on 'Nova Lista'
    fill_in 'Nome', with: other_recipe_list.name
    click_on 'Enviar'
    #assert
    expect(page).to have_css('h3',text: other_recipe_list.name)
    expect(page).to have_css('h4',text:'Esta lista ainda esta vazia')
  end

  scenario 'and has no lists' do
    #arrange
    user = create(:user)
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Listas'
    #assert
    expect(page).to have_css('h3', text:'Você ainda não possui nenhuma lista')
    expect(page).to have_link('Nova Lista')
  end
  scenario 'and must be logged in' do
    #act
    visit root_path
    #assert
    expect(page).not_to have_link('Minhas Listas')
  end
  scenario 'and must be logged in to access route' do
    #act
    visit recipe_lists_path
    #assert
    expect(current_path).to eq new_user_session_path
  end
end
