require 'rails_helper'
FactoryBot.find_definitions

feature 'admin validates pending recipe' do
  scenario 'and activates it' do
    admin = create(:admin)
    recipe =  create(:recipe)
     #act
     login_as(admin, scope: :user)
     visit root_path

     click_on 'Receitas Pendentes'
     click_link("recipe-#{recipe.id}")
     click_on 'Ativar'
     #assert
     expect(page).to have_content('Receita Validada com Sucesso')
     expect(current_path).to eq pending_recipes_path
  end

  scenario 'and rejects it' do

    admin = create(:admin)
    recipe = create(:recipe)
     #act
     login_as(admin, scope: :user)
     visit root_path

     click_on 'Receitas Pendentes'
     click_link("recipe-#{recipe.id}")
     click_on 'Rejeitar'
     #assert
     expect(page).to have_content('Receita Rejeitada com Sucesso')
     expect(current_path).to eq pending_recipes_path
  end

  scenario 'and must be admin' do
    #arrange
    user = create(:user, email: 'user@mail.com')
    recipe = create(:recipe, title: 'Bolo de Cenoura')
    #act
    login_as(user, scope: :user)
    visit root_path

    expect(page).not_to have_link('Receitas Pendentes')
    expect(page).not_to have_content('Bolo de cenoura')
  end

  scenario 'and must be admin to access link' do
    #arrange
    user = create(:user, email: 'user@mail.com')
    recipe = create(:recipe, title: 'Bolo de Cenoura')
    #act
    login_as(user, scope: :user)
    visit pending_recipes_path

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Ativar')
    expect(page).not_to have_link('Rejeitar')
    expect(page).not_to have_content('Bolo de cenoura')
  end
end
