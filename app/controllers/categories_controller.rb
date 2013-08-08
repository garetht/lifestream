class CategoriesController < ApplicationController
  def index
    @hash = Category.children_hash(current_user.id)
    @root = @hash[nil]
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def update
    @category = Category.find_by_id(params[:id])
    if params[:new_parent_id] == "null"
      @category.update_attributes(parent_id: nil)
    else
      @category.update_attributes(parent_id: params[:new_parent_id].to_i)
    end
    respond_to do |format|
      format.json {render json: @category}
    end
  end
end
