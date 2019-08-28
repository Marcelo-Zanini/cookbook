require 'rails_helper'

feature 'admin validates pending recipe' do
  scenario 'and activates it' do
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
     #act
     visit root_path
     click_on 'Entrar'

     within('.formulario') do
       fill_in 'Email', with: admin.email
       fill_in 'Senha', with: '123456'
       click_on 'Entrar'
     end
     click_on 'Receitas Pendentes'
     click_link("recipe-#{recipe.id}")
     click_on 'Ativar'
     #assert
     expect(page).to have_content('Receita Validada com Sucesso')
     expect(current_path).to eq pending_recipes_path
  end

  scenario 'and activates it' do
    user = User.create(email: 'marcelo@teste.com', password: '123456')
    admin = User.create(email: 'gere@teste.com', password: '123456', admin: true)
    recipe_list = RecipeList.create(user: user, name: 'Gostosuras')
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           user: user, cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
     #act
     visit root_path
     click_on 'Entrar'

     within('.formulario') do
       fill_in 'Email', with: admin.email
       fill_in 'Senha', with: '123456'
       click_on 'Entrar'
     end
     click_on 'Receitas Pendentes'
     click_link("recipe-#{recipe.id}")
     click_on 'Rejeitar'
     #assert
     expect(page).to have_content('Receita Rejeitada com Sucesso')
     expect(current_path).to eq pending_recipes_path
  end
end
