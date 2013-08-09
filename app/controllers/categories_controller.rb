class CategoriesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @hash = Category.children_hash(current_user.id)
    @root = @hash[nil]
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end

  def create
    params[:category][:parent_id] = nil
    params[:category][:user_id] = current_user.id
    @category = Category.new(params[:category])
    if @category.save
      respond_to do |format|
        format.json {render json: @category}
      end
    else
      set_error "We could not save your category."
    end
  end

  def update
    if belongs_to_current_user params[:id]
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

  def destroy
    if belongs_to_current_user params[:id]
      @category = Category.find_by_id(params[:id])
      children = @category.children
      children.each {|child| child.update_attributes(parent_id: nil)}
      @category.destroy
    else
      flash[:alerts] = "That stream does not belong to you."
    end
  end

  def belongs_to_current_user(id)
    current_user.categories.pluck(:id).include?(id.to_i)
  end
end
