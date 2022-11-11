require 'rails_helper'

RSpec.describe Recipe do
  before :each do
    @recipe = Recipe.new({recipe: {id: "null", label: "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)", url: "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html", image: "https://edamam-product-images.s3.amazonaws.com"}, q: "thailand"})
  end

  it 'exists' do
    expect(@recipe).to be_a(Recipe)
  end

  it 'has an id, title, url, image, and country' do
    expect(@recipe.id).to eq("null")
    expect(@recipe.title).to eq("Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)")
    expect(@recipe.url).to eq("https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html")
    expect(@recipe.image).to eq("https://edamam-product-images.s3.amazonaws.com")
    expect(@recipe.country).to eq("thailand")
  end
end