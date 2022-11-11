class RecipeSerializer
  def self.format_recipes(country)
    {
      data: RecipeFacade.get_recipes(country)[1].map do |recipe|
        {
          id: recipe.id,
          type: "recipe",
          attributes: {
            title: recipe.title,
            url: recipe.url,
            country: RecipeFacade.get_recipes(country)[0],
            image: recipe.image
          }
        }
      end

    }
  end
end
# {
#   "data": [
#       {
#           "id": null,
#           "type": "recipe",
#           "attributes": {
#               "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
#               "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
#               "country": "thailand",
#               "image": "https://edamam-product-images.s3.amazonaws.com..."
#           }
#       },
#       {
#           "id": null,
#           "type": "recipe",
#           "attributes": {
#               "title": "Sriracha",
#               "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
#               "country": "thailand",
#               "image": "https://edamam-product-images.s3.amazonaws.com/."
#           }
#       },
#       {...},
#       {...},
#       {...},
#       {etc},
#   ]
# }