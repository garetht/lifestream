class PostsController < ApplicationController
  def index
    @streamid = params[:stream_id]
  end

  def new
    @streamid = params[:stream_id]
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to stream_post_url(1, @post.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end
end
