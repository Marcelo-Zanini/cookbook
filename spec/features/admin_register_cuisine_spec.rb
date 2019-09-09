require 'rails_helper'


feature 'Admin register recipe_type' do
  scenario 'successfully' do
    #arranje
    admin = create(:admin)
    #act
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: 'Japonesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h3', text: 'Japonesa')
  end

  scenario 'and must fill name field' do
    #arranje
    admin = create(:admin)
    #act
    login_as(admin, scope: :user)
    visit root_path
    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
    expect(page).to have_content('Nome não pode ficar em branco')
  end


  scenario 'and must be unique' do
    #arranje
    cuisine = create(:cuisine, name: 'Japonesa')
    admin = create(:admin)
    #act
    login_as(admin, scope: :user)
    visit root_path

    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: cuisine.name
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
    expect(page).to have_content('Nome já está em uso')
  end
end
