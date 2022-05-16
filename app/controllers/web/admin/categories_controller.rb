# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    authorize [:admin, Category]
    @categories = Category.page(params[:page]).per(15)
    @category = Category.new
  end

  def create
    authorize [:admin, Category]
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: t('.fail')
    end
  end

  def destroy
    authorize [:admin, Category]
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: t('.fail')
    end
  end

  def category_params
    params.require(:category).permit([:name])
  end
end
