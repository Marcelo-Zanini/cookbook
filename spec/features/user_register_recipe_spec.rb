require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    user = User.create(email: 'marcelo@teste.com', password: '123456')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Enviar uma receita'
    attach_file('Imagem', "spec/files/images/bolo_cenoura.jpg")
    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Sobremesa', from: 'Tipo da Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Farinha, açucar, cenoura'
    fill_in 'Como Preparar', with: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css("img[src*='bolo_cenoura.jpg']")
    expect(page).to have_css('h4', text: "Receita enviada por #{user.email}")
    expect(page).to have_css('h3', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Farinha, açucar, cenoura')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
  end

  scenario 'and must fill in all fields' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Enviar uma receita'
    user = User.create(email: 'marcelo@teste.com', password: '123456')

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a receita')
  end
  scenario 'and new recipe is pending for validation' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(name: 'Brasileira')
    Cuisine.create(name: 'Arabe')
    user = User.create(email: 'marcelo@teste.com', password: '123456')

    # simula a ação do usuário
    visit root_path
    click_on 'Entrar'

    within('.formulario') do
      fill_in 'Email', with: user.email
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Enviar uma receita'
    attach_file('Imagem', "spec/files/images/bolo_cenoura.jpg")
    fill_in 'Título', with: 'Bolo de cenoura'
    select 'Sobremesa', from: 'Tipo da Receita'
    select 'Brasileira', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Farinha, açucar, cenoura'
    fill_in 'Como Preparar', with: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_content('Receita Aguardando Aprovação')
    expect(page).to have_css('h3', text: 'Bolo de cenoura')
  end
end
