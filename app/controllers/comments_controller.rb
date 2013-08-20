class CommentsController < ApplicationController
  def new
  end

  def create
    params[:comment][:user_id] = current_user.id
    @comment = Comment.new(params[:comment])
    if @comment.save
      if request.xhr?
        render partial: "comment", locals: {hash: Hash.new(Array.new), 
        children: [@comment], first: !@comment.parent_id, current: @comment.id,
        post_id: @comment.post_id}
      else
        render json: @comment
      end
    end
  end

  def destroy
  end

  def show
    @hash = Comment.children_hash(12)
    @root = @hash[nil]
  end

  def update
    @comment = Comment.find_by_id(params[:id])
    if @comment.user_id = current_user.id
      @comment.update_attributes(params[:comment])
    end
    if request.xhr?
      render json: @comment.text.to_json
    end
  end
end
