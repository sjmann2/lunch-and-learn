class RecipeFacade
  def self.get_recipes(country)
    response = RecipeService.get_recipes(country)
    recipes = response[:hits].map do |data|
      Recipe.new(data)
    end
    country, recipes = [response[:q], recipes]
  end
end