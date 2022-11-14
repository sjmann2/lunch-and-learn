class Api::V1::TouristSightsController < ApplicationController
  def index
    sights = TouristSightFacade.get_sights(params[:country])
    render json: TouristSightSerializer.new(sights)
  end
end