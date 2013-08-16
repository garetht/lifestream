class StreamsController < ApplicationController

  before_filter :authenticate_user!

  def create
    params[:stream][:user_id] = current_user.id
    @stream = Stream.new(params[:stream])
    @stream.save

    if request.xhr?
      render @stream
    else
      respond_to do |format|
        format.json {render json: @stream.to_json}
      end
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
      old_default = current_user.default_stream_id
      new_default = params[:id]
      current_user.update_attributes(default_stream_id: new_default)
      respond_to do |format|
        format.json {render json: {old: old_default, new: new_default.to_i}}
      end
    end
  end

  def belongs_to_current_user(id)
    current_user.streams.pluck(:id).include?(id.to_i)
  end

end