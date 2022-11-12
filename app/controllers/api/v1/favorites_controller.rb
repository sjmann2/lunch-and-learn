class Api::V1::FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(favorite_params)
    if favorite.save
      render json: FavoriteSerializer.new(favorite)
    else
      error = ErrorSerializer.new(favorite.errors.full_messages, 'BAD REQUEST', 400)
      render json: error.serialized_message, status: 400
    end
  end
end