require 'rails_helper'

describe 'Post recipe type via Api' do
  it 'creates recipe type successfully' do
    #act
    post api_v1_recipe_types_path, params: {recipe_type: {name:'Sobremesa'}}
    #assert
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 201
    expect(json_recipe_type[:name]).to eq 'Sobremesa'
  end
  it 'and must be unique' do
    #arrange
    create(:recipe_type, name: 'Sobremesa')
    #act
    post api_v1_recipe_types_path, params: {recipe_type: {name:'Sobremesa'}}
    #assert
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 406
    expect(json_recipe_type).to include 'Nome já está em uso'
  end
  it 'and can not be blank' do

    #act
    post api_v1_recipe_types_path, params: {recipe_type: {name:''}}
    #assert
    json_recipe_type = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq 406
    expect(json_recipe_type).to include 'Nome não pode ficar em branco'
  end
end
