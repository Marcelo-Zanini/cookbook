class Api::V1::RecipesController < Api::V1::ApiController
  def show
    recipe = Recipe.find(params[:id])
    render json: recipe, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: {msg: 'Receita não encontrada' }, status: :not_found
  end

  def create
    recipe = Recipe.new(set_params)
    recipe.save!
    render json: recipe, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: recipe.errors.full_messages, status: :precondition_failed
  end

  def destroy
    recipe = Recipe.find(params[:id])
    render json: "#{recipe.title} excluida com sucesso", status: :accepted
  end

  private
  def set_params
    parameters = params.require(:recipe).permit(%i[user_id title recipe_type_id cuisine_id
       difficulty cook_time ingredients cook_method picture])
  end
end
