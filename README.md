# Description 
This is the back-end API for a fictional app "Lunch and Learn", an application that allows users to search for recipes by country, favorite recipes, and learn more about a particular country. The endpoints exposed on this API can be consumed by a team of front-end developers to build out the functionality of the app.

This app consumes four external APIs and consolidates the data to be consumed by the front end:
* Randomizing a country for the user to learn about is provided by consuming the [REST Countries API](https://restcountries.com)
* Exploring recipes specific to a country is provided by consuming the [Edamam Recipe API](https://developer.edamam.com/edamam-recipe-api)
* Learning resources for a particular country, including images of that country and a short history video, are provided by consuming the [Unsplash API](https://unsplash.com/documentation) and the [Youtube API](https://developers.google.com/youtube/v3/getting-started)

# Technology Used
* Rails 5.2.6
* Ruby 2.7.4
* PostgreSQL Database
* [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer) for API response serialization

# Local Setup Directions
```
git clone git@github.com:sjmann2/lunch-and-learn.git

cd lunch-and-learn

bundle install

rails db:{create,migrate}

rails s
```

# Database Schema Diagram
![lunch-and-learn db](https://user-images.githubusercontent.com/99758586/201795623-337ddea2-568f-42c0-a20d-6da1786aec13.png)

# Endpoint Available
## Base URL
http://localhost:3000/api/v1

## Get recipes for a random country
GET `/recipes/country`
### Example response
```
{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Singapore Fling",
                "url": "https://food52.com/recipes/82481-singapore-fling",
                "country": "Singapore",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Singapore Noodles",
                "url": "http://norecipes.com/blog/2011/11/13/singapore-noodles-recip/",
                "country": "Singapore",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        }
    ]
}    
