class Api::V1::FavoritesController < ApplicationController
  before_action :set_user

  def index
    return render_error("Could not find user with api_key #{params[:api_key]}", 'NOT FOUND', 404) if @user.nil?
    favorites = @user.favorites
    render json: FavoriteSerializer.new(favorites)
  end

  def create
    return render_error("Could not find user with api_key #{params[:api_key]}", 'NOT FOUND', 404) if @user.nil?
    favorite = @user.favorites.new(favorite_params)
    if favorite.save
      render json: FavoriteSerializer.post_favorite, status: 201
    else
      render_error(favorite.errors.full_messages, 'BAD REQUEST', 400)
    end
  end

  def destroy
    @user.favorites.find(params[:favorite_id]).destroy
  end

  private
  
  def set_user
    @user = User.find_by(api_key: params[:api_key])
  end

  def render_error(message, status, code)
    error = ErrorSerializer.new(message, status, code)
    render json: error.serialized_message, status: code
  end

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end