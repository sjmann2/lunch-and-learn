class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    favorite = user.favorites.new(favorite_params)
    if favorite.save
      render json: FavoriteSerializer.post_favorite, status: 201
    else
      error = ErrorSerializer.new(favorite.errors.full_messages, 'BAD REQUEST', 400)
      render json: error.serialized_message, status: 400
    end
  end

  private
  
  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end