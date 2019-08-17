class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update]


  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(set_params)
    if @recipe.save
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(set_params)
      redirect_to @recipe
    else
      flash.now[:alert] = 'Você deve informar todos os dados da receita'
      render :edit
    end
  end

  private

  def set_params
    params.require(:recipe).permit(%i[title recipe_type cuisine difficulty
      cook_time ingredients cook_method])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

end
