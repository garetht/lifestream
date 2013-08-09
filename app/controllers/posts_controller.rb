class PostsController < ApplicationController
  def index
    if params[:stream_id]
      @streamid = params[:stream_id]
      # This needs to be thisstream.posts
      @posts = Stream.find(@streamid).posts.order("created_at DESC")
    else
      @streamid = current_user.default_stream_id
      @posts = current_user.posts.order("created_at DESC")
    end
  end

  def new
    @streamid = params[:stream_id]
    # for select2
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

  # Is there a way to get Rails to generate the missing categories
  # by itself?
  # process_categories
  #
  #   STRING
  #   Argument: a comma-separated STRING representing the names of the
  #   categories (Category.name) to be applied to the Post. This
  #   information comes directly from the user.
  #   
  #   [INT]
  #   Returns: an ARRAY of INT category ids (Category.id) that are the
  #   final categories to be applied to the post. New categories are
  #   created if the user specifies new categories, and are given a 
  #   parent_id of nil. Categories that exist also have all parent
  #   categories added to them.

  def process_categories(categories)
    names = Set.new(categories.split(","))
    matching = Category.where("name IN (?)", names)
    parents = get_parents matching
    matching_names = Set.new(matching.pluck(:name))
    category_ids = parents + add_categories(names - matching_names)
  end

  def add_categories(names)
    return [] if names.empty?
    new_category_ids = []
    names.each do |name|
      cat = Category.create(name: name, user_id: current_user.id, parent_id: nil)
      new_category_ids << cat.id
    end
    new_category_ids
  end

  def get_parents(categories)
    all_parents = categories.map do |category|
      category.trace_id_path
    end 
    all_parents.flatten.uniq
  end

end
