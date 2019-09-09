require 'rails_helper'

feature 'User view owned recipes' do
  scenario 'successfully' do
    #arrange
    user = create(:user)
    other_user = create(:user)
    recipe = create(:recipe, user: user)
    other_recipe = create(:recipe, user: user)
    another_recipe = create(:recipe, user: other_user)
    #act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Receitas'
    #assert
    expect(page).to have_css('.owner', text: "Receitas criadas por #{user.email}")
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).not_to have_content(another_recipe.title)
  end
  scenario 'and must be logged in' do
    #act
    visit root_path
    #assert
    expect(page).not_to have_link('Minhas Receitas')
  end

  scenario 'and must be logged in to access route' do
    #act
    visit my_recipes_path
    #assert
    expect(current_path).to eq new_user_session_path
  end
end
