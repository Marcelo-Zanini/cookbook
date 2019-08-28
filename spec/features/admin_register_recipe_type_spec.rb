require 'rails_helper'

feature 'Admin register recipe_type' do
  scenario 'successfully' do
    #arranje
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Prato Principal'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h3', text: 'Prato Principal')
  end

  scenario 'and must fill name field' do
    #arranje
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
  end


  scenario 'and must be unique' do
    #arranje
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    recipe_type = RecipeType.create(name: 'Sobremesa')

    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar Tipo de Receita'
    fill_in 'Nome', with: 'Sobremesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar tipo de receita')
  end
end
