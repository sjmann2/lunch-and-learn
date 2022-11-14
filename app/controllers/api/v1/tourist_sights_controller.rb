class Api::V1::TouristSightsController < ApplicationController
  def index
    if params[:country]
      sights = TouristSightFacade.get_sights(params[:country])
    else
      sights = TouristSightFacade.get_sights
    end
    render json: TouristSightSerializer.new(sights)
  end
end