class RecipeListsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new show]

  def index
    @recipe_lists = RecipeList.where(user: current_user)
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(params.require(:recipe_list).permit(:name))
    @recipe_list.user = current_user
    return redirect_to @recipe_list if @recipe_list.save

    catch_save :new
  end

  def show
    @recipe_list = RecipeList.find(params[:id])
  end

  private
  def catch_save(view)
    flash.now[:alert] = 'Não foi possível criar lista'
    render view
  end
end
