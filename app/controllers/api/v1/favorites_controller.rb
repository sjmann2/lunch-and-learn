class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      error = ErrorSerializer.new("No user found with api_key #{params[:api_key]}", 'NOT FOUND', 404)
      render json: error.serialized_message, status: 404
      return
    end
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