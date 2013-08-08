class StreamsController < ApplicationController
  def create
    params[:stream][:user_id] = current_user.id
    @stream = Stream.new(params[:stream])
    @stream.save

    respond_to do |format|
      format.json {render json: @stream.to_json}
    end
  end

  def new
  end

  def destroy
  end

  def index
    @streams = current_user.streams
  end

  def default
    if current_user.streams.pluck(:id).include?(params[:id].to_i)
      current_user.update_attributes(default_stream_id: params[:id])
      respond_to do |format|
        format.json {render json: "Success".to_json}
      end
    end

  end

end