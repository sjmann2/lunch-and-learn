class Api::V1::TouristSightsController < ApplicationController
  def index
    render json: TouristSightFacade.get_sights(params[:country])
  end
end