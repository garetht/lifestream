class CategoriesController < ApplicationController
  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end
end
