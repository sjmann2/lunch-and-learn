class Api::V1::LearningResourcesController < ApplicationController
  def index
    @country = params[:country]
    video = VideoFacade.get_video(@country)
    photos = PhotoFacade.get_photos(@country)
    render json: LearningResoucesSerializer.format_resources(video, photos)
  end
end