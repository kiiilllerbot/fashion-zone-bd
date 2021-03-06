class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = current_user.categories.build
  end

  def edit
    authorize! :edit, @category
  end

  def create
    authorize! :create, @category
    @category = current_user.categories.build(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully saved." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize! :update, @category
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :destroy, @category
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end
end
