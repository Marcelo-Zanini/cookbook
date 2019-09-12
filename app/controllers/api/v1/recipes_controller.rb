class Api::V1::RecipesController < Api::V1::ApiController
  before_action :find_recipe, only: %i[ show validate destroy ]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def create
    recipe = Recipe.new(set_params)
    recipe.save!
    render json: recipe, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: recipe.errors.full_messages, status: :precondition_failed
  end

  def show
    render json: @recipe, status: :ok
  end

  def validate
    return render json: {msg:'Receita não está pendente'},
      status: :precondition_failed unless @recipe.pending?

    case params[:status]
    when 'rejected'
      @recipe.rejected!
    when 'active'
      @recipe.active!
    end
    render json: @recipe, status: :ok
  end

  def destroy
    @recipe.destroy
    render json: "#{@recipe.title} excluida com sucesso", status: :accepted
  end

  private

  def set_params
    parameters = params.require(:recipe).permit(%i[user_id title recipe_type_id cuisine_id
       difficulty cook_time ingredients cook_method picture])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def not_found_error
    render json: {msg: 'Receita não encontrada' }, status: :not_found
  end

end
