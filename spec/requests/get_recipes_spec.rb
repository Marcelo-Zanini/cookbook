require 'rails_helper'

describe 'Get recipes list' do

  it 'successfully' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipes.size).to eq 5
    expect(json_recipes[0][:title]).to eq 'Recipe1'
    expect(json_recipes[1][:title]).to eq 'Recipe2'
    expect(json_recipes[2][:title]).to eq 'Recipe3'
    expect(json_recipes[3][:title]).to eq 'Recipe4'
    expect(json_recipes[4][:title]).to eq 'Recipe5'
  end

  it 'and must have at least one item' do
    #act
    get api_v1_recipes_path
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert

    expect(response.status).to eq 404
    expect(json_recipes[:msg]).to eq 'Não há receitas disponíveis'
  end

  it 'filtered by active status successfully' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path, params: {status: 'active'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipes.size).to eq 2
    expect(json_recipes[0][:title]).to eq 'Recipe1'
    expect(json_recipes[1][:title]).to eq 'Recipe3'
  end

  it 'filtered by active status and must have at least one item' do
    #arrange
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path,params:{status: 'active'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert

    expect(response.status).to eq 404
    expect(json_recipes[:msg]).to eq 'Não há receitas disponíveis'
  end

  it ' filtered by rejected status successfully' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path, params: {status: 'rejected'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipes.size).to eq 1
    expect(json_recipes[0][:title]).to eq 'Recipe4'
  end

  it 'filtered by rejected status and must have at least one item' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    #act
    get api_v1_recipes_path,params:{status: 'rejected'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert

    expect(response.status).to eq 404
    expect(json_recipes[:msg]).to eq 'Não há receitas disponíveis'
  end

  it ' filtered by pending status successfully' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path, params: {status: 'pending'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipes.size).to eq 2
    expect(json_recipes[0][:title]).to eq 'Recipe2'
    expect(json_recipes[1][:title]).to eq 'Recipe5'
  end

  it 'filtered by pending status and must have at least one item' do
    #arrange
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    #act
    get api_v1_recipes_path,params:{status: 'pending'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert

    expect(response.status).to eq 404
    expect(json_recipes[:msg]).to eq 'Não há receitas disponíveis'
  end

  it 'and must override wrong status' do
    #arrange
    create(:recipe,title:'Recipe1',status: 'active')
    create(:recipe,title:'Recipe2',status: 'pending')
    create(:recipe,title:'Recipe3',status: 'active')
    create(:recipe,title:'Recipe4',status: 'rejected')
    create(:recipe,title:'Recipe5',status: 'pending')
    #act
    get api_v1_recipes_path,params:{status: 'banana'}
    json_recipes = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 200
    expect(json_recipes.size).to eq 5
    expect(json_recipes[0][:title]).to eq 'Recipe1'
    expect(json_recipes[1][:title]).to eq 'Recipe2'
    expect(json_recipes[2][:title]).to eq 'Recipe3'
    expect(json_recipes[3][:title]).to eq 'Recipe4'
    expect(json_recipes[4][:title]).to eq 'Recipe5'
  end

end
