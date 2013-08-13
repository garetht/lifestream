class CommentsController < ApplicationController
  def new
  end

  def create
    params[:comment][:user_id] = current_user.id
    @comment = Comment.new(params[:comment])
    if @comment.save
      p @comment
      if request.xhr?
        p "request is xhr"
        p [@comment]
        render partial: "comment", locals: {hash: {}, children: [@comment], first: false, current: @comment.id}
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
end
