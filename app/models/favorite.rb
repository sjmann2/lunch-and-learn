class Favorite < ApplicationRecord
  belongs_to :user
  validates_presence_of :api_key, :country, :recipe_link, :recipe_title
end