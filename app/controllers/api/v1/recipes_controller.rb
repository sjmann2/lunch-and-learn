class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country]
      country = params[:country]
      recipes = RecipeFacade.get_recipes(country)
    else
      country = CountryFacade.get_country
      recipes = RecipeFacade.get_recipes(country.name)
    end
    render json: RecipeSerializer.format_recipes(recipes)
  end
end