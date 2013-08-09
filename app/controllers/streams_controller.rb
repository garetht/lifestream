class StreamsController < ApplicationController

  before_filter :authenticate_user!

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
    if belongs_to_current_user params[:id]
      current_user.update_attributes(default_stream_id: params[:id])
      respond_to do |format|
        format.json {render json: "Success".to_json}
      end
    end
  end

  def belongs_to_current_user(id)
    current_user.streams.pluck(:id).include?(id.to_i)
  end

end