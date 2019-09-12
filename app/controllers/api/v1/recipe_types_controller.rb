class Api::V1::RecipeTypesController < Api::V1::ApiController

  before_action :find_recipe_type, only: %i[ show ]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def create
    recipe_type = RecipeType.new(set_params)
    recipe_type.save!
    render json: recipe_type, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: recipe_type.errors.full_messages, status: :not_acceptable
  end

  def show
    render json: @recipe_type.as_json(include: :recipes), status: :ok
  end

  private

  def set_params
    params.require(:recipe_type).permit(:name)
  end

  def find_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def not_found_error
    render json: {msg: 'Tipo de Receita não encontrado' }, status: :not_found
  end

end
