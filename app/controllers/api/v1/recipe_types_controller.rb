class Api::V1::RecipeTypesController < Api::V1::ApiController
  def create

    recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
    recipe_type.save!
    render json: recipe_type, status: :created
  rescue ActiveRecord::RecordInvalid
    render json: recipe_type.errors.full_messages, status: :not_acceptable
  end
end
