require 'rails_helper'

describe 'Get recipe type details' do
  it 'and finds recipe type' do
    #arrange
    recipe_type = create(:recipe_type, name: 'Tipo 1')
    #act
    get api_v1_recipe_type_path(recipe_type)
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipe_type[:name]).to eq 'Tipo 1'
  end

  it 'and show recipes from recipe types' do
    #arrange
    recipe_type = create(:recipe_type, name: 'Tipo 1')
    recipe = create(:recipe, title: 'Recipe 1', recipe_type: recipe_type)
    other_recipe = create(:recipe, title: 'Recipe 2', recipe_type: recipe_type)
    #act
    get api_v1_recipe_type_path(recipe_type)
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipe_type[:name]).to eq 'Tipo 1'
    expect(response.body).to include recipe.title
    expect(response.body).to include other_recipe.title
  end
  it "and must not contain other type's recipes" do
    #arrange
    recipe_type = create(:recipe_type, name: 'Tipo 1')
    recipe = create(:recipe, title: 'Recipe 1', recipe_type: recipe_type)
    wrong_recipe = create(:recipe, title: 'Wrong Recipe')
    #act
    get api_v1_recipe_type_path(recipe_type)
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipe_type[:name]).to eq 'Tipo 1'
    expect(response.body).to include recipe.title
    expect(response.body).not_to include wrong_recipe.title
  end
end
