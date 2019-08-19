require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    #arranje

    #act
    visit root_path
    click_on 'Enviar cozinha'
    fill_in 'Nome', with: 'Japonesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h1', text: 'Japonesa')
  end

  scenario 'and must fill name field' do
    #arranje
    visit root_path
    click_on 'Enviar cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
  end


  scenario 'and must be unique' do
    #arranje
    cuisine = Cuisine.create(name: 'Japonesa')

    #act
    visit root_path
    click_on 'Enviar cozinha'
    fill_in 'Nome', with: cuisine.name
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
  end
end
