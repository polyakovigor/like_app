class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_category, only: %i[show destroy]

  def index
    @categories = Category.preload(:images).page(params[:page])
  end

  def show
    @images = @category.images.page(params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      flash[:success] = 'Category created. Now you can add some images.'
      redirect_to category_path(@category)
    else
      flash[:error] = @category.errors.full_messages
      render :new
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'Category deleted.'
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
