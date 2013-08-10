class PassThroughController < ApplicationController

  def get
    response = RestClient.get params[:apiurl], {params: params[:params]}
    if params[:type] == "xml"
      response = Hash.from_xml(response).to_json
    end
    render json: response
  end

end
