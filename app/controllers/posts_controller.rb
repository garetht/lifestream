class PostsController < ApplicationController
  def index
    if params[:stream_id]
      @streamid = params[:stream_id]
      # This needs to be thisstream.posts
      @posts = Stream.find(@streamid).posts
    else
      @streamid = current_user.default_stream_id
      @posts = current_user.posts
    end
  end

  def new
    @streamid = params[:stream_id]
    @post = Post.new
  end

  def create
    params[:post][:stream_id] = params[:stream_id]
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
    @post = Post.find(params[:id])
  end

  def destroy
  end
end
