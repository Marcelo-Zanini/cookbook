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
    #arrange
    recipe = create(:recipe, title: 'The Old One', status: 'active')
    #act
    patch api_v1_validate_recipe_path(id: recipe, status: 'rejected')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(json_recipe[:msg]).to eq 'Receita não está pendente'
    expect(response.status).to eq 412
  end

  it 'and must cancel operation on wrong status' do
    #arrange
    recipe = create(:recipe, title: 'The Banana', status: 'pending')
    #act
    patch api_v1_validate_recipe_path(id: recipe, status: 'banana')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(response.status).to eq 422
    expect(json_recipe[:msg]).to eq 'Status banana não existe'
  end

  it 'and must recieve a status' do
    #arrange
    recipe = create(:recipe, title: 'The Unchanging', status: 'pending')
    #act
    patch api_v1_validate_recipe_path(id: recipe)
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(response.status).to eq 406
    expect(json_recipe[:msg]).to eq 'Status é obrigatório'
  end

  it 'AND DO NOT BREW COFFEE WITH MY GOD DAMN TEAPOT' do
    #arrange
    recipe = create(:recipe, title: 'The Teapot', status: 'pending')
    #act
    patch api_v1_validate_recipe_path(id: recipe, status:'coffee')
    json_recipe = JSON.parse(response.body, symbolize_names: true)
    recipe.reload
    #assert
    expect(response.status).to eq 418
    expect(json_recipe[:msg]).to eq 'HOW DARE YOU TRY TO BREW COFFEE ON MY TEAPOT?!?!'
  end

end
