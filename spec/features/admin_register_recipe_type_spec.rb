require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    #arranje

    #act
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h3', text: 'Prato Principal')
  end

  scenario 'and must fill name field' do
    #arranje
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
  end


  scenario 'and must be unique' do
    #arranje
    recipe_type = RecipeType.create(name: 'Sobremesa')

    #act
    visit root_path
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
  end
end
