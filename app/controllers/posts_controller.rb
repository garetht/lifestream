class PostsController < ApplicationController

  before_filter :authenticate_user!

  def index
    is_users_stream = current_user.streams.pluck(:id).include?(params[:stream_id].to_i)
    if params[:stream_id] && is_users_stream
      @streamid = params[:stream_id]
      # This needs to be thisstream.posts
      @posts = Stream.find(@streamid).posts.order("created_at DESC")
    elsif params[:stream_id] == nil
      @posts = current_user.all_posts
    elsif !is_users_stream
      set_error "You are not authorized to view that stream."
      redirect_to stream_posts_url(current_user.default_stream_id)
    end
    @cupids = current_user.posts.pluck(:id)
  end

  def new
    @streamid = params[:stream_id]
    # for select2 dropdown box
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
    @json = Post.find(params[:id]).to_gmaps4rails
  end

  def update
  end

  def show
    @cupids = current_user.posts.pluck(:id)
    if @cupids.include?(params[:id].to_i)
      @post = Post.find(params[:id])
    else
      set_error "You are not authorized to access that post."
    end
  end

  def destroy
  end

  def publicize
    @post = Post.find_by_id(params[:id])
    if @post.public_type == "public" 
      @post.update_attributes(public_type: "private")
    elsif @post.public_type == "private" || !@post.public_type
      @post.update_attributes(public_type: "public")
    end
    render json: @post.public_type.to_json
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
