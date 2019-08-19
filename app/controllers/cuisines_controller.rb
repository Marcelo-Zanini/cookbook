class CuisinesController < ApplicationController

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(set_params)
    if @cuisine.save
      redirect_to @cuisine
    else
      flash.now[:alert] = 'Não foi possível salvar cozinha'
      render :new
    end
  end

  def show
    @cuisine = Cuisine.find(params[:id])
  end

  private
  def set_params
    params.require(:cuisine).permit(:name)
  end
end
