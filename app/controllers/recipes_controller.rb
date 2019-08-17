class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(set_params)
    @recipe.save
    redirect_to @recipe
  end

  private
  def set_params
    params.require(:recipe).permit(%i[title recipe_type cuisine difficulty
      cook_time ingredients cook_method])
  end
end
