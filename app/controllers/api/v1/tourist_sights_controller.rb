class Api::V1::TouristSightsController < ApplicationController
  def index
    if params[:country] && CountryService.get_country(params[:country])[:status] == 404
      return render_error("Couldnt not find country with name #{params[:country]}", "NOT FOUND", 404)
    elsif params[:country]
      sights = TouristSightFacade.get_sights(params[:country])
    else
      sights = TouristSightFacade.get_sights
    end
    render json: TouristSightSerializer.new(sights)
  end

  private
  def render_error(message, status, code)
    error = ErrorSerializer.new(message, status, code)
    render json: error.serialized_message, status: code
  end
end