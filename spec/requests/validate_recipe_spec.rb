require 'rails_helper'

describe 'Validate recipe' do

  it 'and activates it' do
    #arrange
    recipe = create(:recipe, title: 'The right one')
    #act
    patch api_v1_validate_recipe_path(id: recipe, status: 'active')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(response.status).to eq 200
    expect(json_recipe[:title]).to eq 'The right one'
    expect(json_recipe[:status]).to eq 'active'
    expect(recipe.status).to eq 'active'
  end

  it 'and rejects it' do
    #arrange
    recipe = create(:recipe, title: 'The wrong one')
    #act
    patch api_v1_validate_recipe_path(id: recipe, status: 'rejected')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(response.status).to eq 200
    expect(json_recipe[:title]).to eq 'The wrong one'
    expect(json_recipe[:status]).to eq 'rejected'
    expect(recipe.status).to eq 'rejected'
  end

  it 'and must exist to validate' do
    #act
    patch api_v1_validate_recipe_path(id: 73, status: 'active')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 404
    expect(json_recipe[:msg]).to eq 'Receita não encontrada'
  end


  it 'and must be pending' do
    recipe = create(:recipe, title: 'The Old One', status: 'active')
    patch api_v1_validate_recipe_path(id: recipe, status: 'rejected')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(json_recipe[:msg]).to eq 'Receita não está pendente'
    expect(response.status).to eq 412
  end

end
