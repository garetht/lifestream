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
    @categories = Category.select('name').
                  where("user_id = ?", current_user.id).
                  pluck(:name)
    @post = Post.new
  end

  def create
    params[:post][:stream_id] = params[:stream_id]
    params[:post][:category_ids] = process_categories(params[:categories])
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

  def process_categories(categories)
    names = Set.new(categories.split(","))
    matching = Category.where("name IN (?)", names)
    matching_names = Set.new(matching.pluck(:name))
    matching.pluck(:id) + add_categories(names - matching_names)
  end

  def add_categories(names)
    return if names.empty?
    new_category_ids = []
    names.each do |name|
      cat = Category.create(name: name, user_id: current_user.id, parent_id: nil)
      new_category_ids << cat.id
    end
    new_category_ids
  end

end
