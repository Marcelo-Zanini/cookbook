class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update add_to_list]
  before_action :set_collections, only: %i[new edit]
  before_action :authenticate_user!, only: %i[new edit my]

  def index
    @recipes = Recipe.all
  end

  def show
    @list_item = ListItem.new
    @recipe_lists = RecipeList.where(user:current_user)
  end

  def my
    @recipes = Recipe.where(user: current_user)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    redirect_to @recipe unless @recipe.owner? current_user
  end

  def create
    @recipe = Recipe.new(set_params)
    @recipe.user = current_user
    return redirect_to @recipe if @recipe.save

    catch_save :new
  end

  def update
    return redirect_to @recipe  if @recipe.update(set_params)

    catch_save :edit
  end

  def add_to_list
    @list_item = ListItem.new(params.require(:list_item).permit(:recipe_list_id))
    @list_item.recipe = @recipe
    if @list_item.save
      flash[:notice] = 'Adicionado à lista com Sucesso'
    else
      @list_item.errors.full_messages.each do |error|
        flash[:alert] = error
      end
    end
    redirect_to @recipe
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:term]}%")
    flash.now[:alert] = 'Receita não encontrada' if @recipes.empty?
  end

  private

  def set_params
    parameters = params.require(:recipe).permit(%i[title recipe_type_id cuisine_id
       difficulty cook_time ingredients cook_method]).to_h.map {|k,v| [k,v.capitalize]}.to_h
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def set_collections
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def catch_save(view)
    set_collections
    flash.now[:alert] = 'Não foi possível salvar a receita'
    render view
  end

end
