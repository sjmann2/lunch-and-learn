class Api::V1::UsersController < ApplicationController
  def create
    require 'pry' ; binding.pry
    user = User.new(user_params)
  end

  private
  def user_params
    params.permit(:name, :email)
  end
end