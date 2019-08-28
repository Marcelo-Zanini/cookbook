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
    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: 'Japonesa'
    click_on 'Enviar'

    #assert
    expect(page).to have_css('h3', text: 'Japonesa')
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
    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
  end


  scenario 'and must be unique' do
    #arranje
    cuisine = Cuisine.create(name: 'Japonesa')
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    #act
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Enviar Cozinha'
    fill_in 'Nome', with: cuisine.name
    click_on 'Enviar'

    #assert
    expect(page).to have_content('Não foi possível salvar cozinha')
  end
end
