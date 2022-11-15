class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email]) if User.exists?(email: params[:email])
    if user.nil?
      render_error("Incorrect email", "NOT FOUND", 404)
    elsif !user.authenticate(params[:password])
      render_error("Incorrect password", "UNAUTHORIZED", 401)
    else
      render json: UserSerializer.new(user)
    end
  
  end

  private

  def render_error(message, status, code)
    error = ErrorSerializer.new(message, status, code)
    render json: error.serialized_message, status: code
  end
end