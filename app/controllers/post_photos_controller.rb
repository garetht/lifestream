class PostPhotosController < ApplicationController
  def create
    @post_photo = PostPhoto.new(params[:post_photo])
    respond_to do |format|
      if @post_photo.save
        format.html {
          render :json => [@post_photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@post_photo.json_data]}, status: :created, location: @post_photo }
      else
        format.html { render action: "new" }
        format.json { render json: @post_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post_photo = PostPhoto.find_by_id(params[:id])
    @post_photo.destroy
  end
end
