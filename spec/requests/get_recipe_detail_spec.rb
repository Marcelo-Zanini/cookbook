require 'rails_helper'

describe 'get recipe details via API' do
  it 'return JSON' do
    #arrange
    recipe = create(:recipe, title: 'Bolo de cenoura')
    #act
    get api_v1_recipe_path(recipe)

    json_recipe = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipe[:title]).to eq recipe.title
  end
  it 'not found' do
    #act
    get api_v1_recipe_path(id: 10)

    json_recipe = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 404
    expect(json_recipe[:msg]).to eq 'Receita não encontrada'
  end
end
