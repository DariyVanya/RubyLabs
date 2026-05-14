class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update destroy]

  def index
    @ingredients = Ingredient.order(:name)
  end

  def show; end
  def new; @ingredient = Ingredient.new; end
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to @ingredient
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit; end
  def update
    if @ingredient.update(ingredient_params)
      redirect_to @ingredient
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @ingredient.destroy
    redirect_to ingredients_path
  end
  private
  def set_ingredient; @ingredient = Ingredient.find(params[:id]); end
  def ingredient_params; params.require(:ingredient).permit(:name); end
end
