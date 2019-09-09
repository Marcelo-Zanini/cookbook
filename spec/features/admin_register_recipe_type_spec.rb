require 'rails_helper'
FactoryBot.find_definitions

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    #arranje
    admin = create(:admin)
    #act
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h3', text: 'Prato Principal')
  end

  scenario 'and must fill name field' do
    #arranje
    admin = create(:admin)
    #act
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
    expect(page).to have_content('Nome não pode ficar em branco')
  end


  scenario 'and must be unique' do
    #arranje
    admin = create(:admin)
    create(:recipe_type, name: 'Sobremesa')

    #act
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
    expect(page).to have_content('Nome já está em uso')
  end
end
