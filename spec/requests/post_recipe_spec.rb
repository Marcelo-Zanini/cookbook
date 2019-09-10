require 'rails_helper'

describe 'Post Recipe' do
  it 'successfully' do
    #arrange
    user = create(:user)
    recipe_type = create(:recipe_type)
    cuisine = create(:cuisine)
    #act
    post api_v1_recipes_path, params: {recipe: {user_id: user.id,
                                                recipe_type_id: recipe_type.id,
                                                cuisine_id: cuisine.id,
                                                title: 'Titulo',
                                                difficulty: 'Difficulty',
                                                cook_time: 10,
                                                ingredients: 'Ingredients',
                                                cook_method: 'Method'}}

    json_recipe = JSON.parse(response.body, symbolize_names: true)
    #assert
    expect(response.status).to eq 201
    expect(json_recipe[:user_id]).to eq user.id
    expect(json_recipe[:recipe_type_id]).to eq recipe_type.id
    expect(json_recipe[:cuisine_id]).to eq cuisine.id
    expect(json_recipe[:title]).to eq 'Titulo'
    expect(json_recipe[:difficulty]).to eq 'Difficulty'
    expect(json_recipe[:cook_time]).to eq 10
    expect(json_recipe[:ingredients]).to eq 'Ingredients'
    expect(json_recipe[:cook_method]).to eq 'Method'
  end
  it 'and must contain all fields' do
    #act
    post api_v1_recipes_path, params: {recipe: {user_id:'',
                                                recipe_type_id: '',
                                                cuisine_id: '',
                                                title: '',
                                                difficulty: '',
                                                cook_time: '',
                                                ingredients: '',
                                                cook_method: ''}}
    #assert
    expect(response.status).to eq 412
    expect(response.body).to include 'Usuário é obrigatório(a)'
    expect(response.body).to include 'Tipo de Receita é obrigatório(a)'
    expect(response.body).to include 'Cozinha é obrigatório(a)'
    expect(response.body).to include 'Título não pode ficar em branco'
    expect(response.body).to include 'Dificuldade não pode ficar em branco'
    expect(response.body).to include 'Tempo de Preparo não pode ficar em branco'
    expect(response.body).to include 'Ingredientes não pode ficar em branco'
    expect(response.body).to include 'Método de Preparo não pode ficar em branco'

    end
end
