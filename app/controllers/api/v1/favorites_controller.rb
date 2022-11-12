class Api::V1::FavoritesController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render_error("No user found with api_key #{params[:api_key]}", 'NOT FOUND', 404)
      return
    end
    favorite = user.favorites.new(favorite_params)
    if favorite.save
      render json: FavoriteSerializer.post_favorite, status: 201
    else
      render_error(favorite.errors.full_messages, 'BAD REQUEST', 400)
    end
  end

  private
  
  def render_error(message, status, code)
    error = ErrorSerializer.new(message, status, code)
    render json: error.serialized_message, status: code
  end

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end