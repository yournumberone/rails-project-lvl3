# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    authorize [:admin, Category]
    @categories = Category.page(params[:page]).per(15)
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    authorize [:admin, Category]
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_category_path(@category), notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    authorize [:admin, Category]
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: @category.errors.first.full_message
    end
  end

  def category_params
    params.require(:category).permit([:name])
  end
end
