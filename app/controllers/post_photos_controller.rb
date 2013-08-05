class PostPhotosController < ApplicationController
  def create
    @post_photo = PostPhoto.create(params[:post_photo])
  end

  def new
  end
end
