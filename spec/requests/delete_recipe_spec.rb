require 'rails_helper'

describe 'Delete recipe' do
  it 'successfully' do
    #arrange
    recipe = create(:recipe, title: 'Receita de teste')
    #act
    delete api_v1_recipe_path(recipe.id)
    #assert
    expect(response.status).to eq 202
    expect(response.body).to include 'Receita de teste excluida com sucesso'
    expect(Recipe.last).to be_falsey
  end

  it 'and must exists' do
    #act
    delete api_v1_recipe_path(id: 001)
    #assert
    expect(response.status).to eq 404
    expect(response.body).to include 'Receita não encontrada'
  end
end
