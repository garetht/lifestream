class PassThroughController < ApplicationController

  def get
    response = RestClient.get params[:url], {params: params[:params]}
    render json: response
  end

end
