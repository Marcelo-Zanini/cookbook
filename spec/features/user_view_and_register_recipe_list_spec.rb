require 'rails_helper'

feature 'User view and register recipe list' do
  scenario 'successfully' do
    #arrange
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
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
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    another_recipe_list = RecipeList.create(user: user, name: 'Gordices')
    other_user = User.create(email: 'gere@teste.com', password: '123456')
    other_recipe_list = RecipeList.create(user: other_user, name: 'Travessuras')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Minhas Listas'
    #assert
    expect(page).to have_css('h3',text: recipe_list.name)
    expect(page).to have_css('h3',text: another_recipe_list.name)
    expect(page).not_to have_content(other_recipe_list.name)

  end

  scenario 'and must have unique name ' do
    #arrange
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
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
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    other_user = User.create(email: 'gere@teste.com', password: '123456')
    other_recipe_list = RecipeList.create(user: other_user, name: 'Travessuras')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
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
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
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
