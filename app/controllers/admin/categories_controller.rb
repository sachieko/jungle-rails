class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_PASSKEY']
  def index
    @categories = Category.left_outer_joins(:products).select('categories.*, COUNT(products.id) as count').group('categories.id').order(id: :desc) 
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :products], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
