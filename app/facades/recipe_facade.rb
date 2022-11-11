class RecipeFacade
  def self.get_recipes(country)
    response = RecipeService.get_recipes(country)
    recipes = response[:hits].map do |hash|
      data = hash.merge(response)
      Recipe.new(data)
    end
  end
end