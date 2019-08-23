require 'rails_helper'

describe Recipe do
  describe 'owner?' do
    it 'true' do
      user = User.create(email: 'marcelo@teste.com', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    user: user, cook_time: 50,
                    ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      expect(recipe.owner?(user)).to eq true
    end
    it 'false' do
      user = User.create(email: 'marcelo@teste.com', password: '123456')
      other_user = User.create(email: 'gere@teste.com', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    user: other_user, cook_time: 50,
                    ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      expect(recipe.owner?(user)).to eq false
    end
    it 'nil = false' do
      user = User.create(email: 'marcelo@teste.com', password: '123456')
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      recipe = Recipe.create(title: 'Bolodecenoura', difficulty: 'Médio',
                    recipe_type: recipe_type, cuisine: cuisine,
                    user: user, cook_time: 50,
                    ingredients: 'Farinha, açucar, cenoura',
                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
      expect(recipe.owner?(nil)).to eq false
    end
  end
end
