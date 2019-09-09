require 'rails_helper'

feature 'Visitor search recipe' do
  scenario 'by full title succesfully' do
    #arranje
    recipe = create(:recipe, title: 'Bolo de cenoura')
    another_recipe = create(:recipe, title: 'Bolo de pote')
    # act
    visit root_path
    fill_in 'Pesquise Receitas Aqui', with: 'Bolo de cenoura'
    click_on 'Buscar'
    #assert
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).not_to have_content(another_recipe.title)
  end

  scenario 'by full title with no results' do
    #arranje
    recipe = create(:recipe, title: 'Bolo de cenoura')
    another_recipe = create(:recipe, title: 'Bolo de pote')
    # act
    visit root_path
    fill_in 'Pesquise Receitas Aqui', with: 'Bolo de fubá'
    click_on 'Buscar'
    #assert
    expect(page).not_to have_content(recipe.title)
    expect(page).not_to have_content(another_recipe.title)
    expect(page).to have_content('Receita não encontrada')
  end
  scenario 'by partial title with some results' do
    #arranje
    recipe = create(:recipe, title: 'Bolo de cenoura')
    another_recipe = create(:recipe, title: 'Bolo de pote')
    third_recipe = create(:recipe, title: 'Risoto')
    # act
    visit root_path
    fill_in 'Pesquise Receitas Aqui', with: 'Bolo'
    click_on 'Buscar'
    #assert
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: another_recipe.title)
    expect(page).not_to have_content(third_recipe.title)
  end
end
