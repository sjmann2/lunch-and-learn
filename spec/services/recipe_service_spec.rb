require 'rails_helper'

RSpec.describe RecipeService do
  it 'returns an HTTP response of recipes given a keyword', :vcr do
    response = RecipeService.get_recipes('thailand')

    expect(response).to be_a(Hash)
    expect(response[:hits]).to be_an(Array)
    expect(response[:q]).to eq("thailand")
    recipe = response[:hits].first
    expect(recipe[:recipe]).to have_key(:uri)
    expect(recipe[:recipe][:uri]).to be_a(String)
    expect(recipe[:recipe][:label]).to be_a(String)
    expect(recipe[:recipe][:image]).to be_a(String)
  end

  it 'returns an empty response if keyword does not match any recipes', :vcr do
    response = RecipeService.get_recipes('fjdklafdksalj')

    expect(response[:hits]).to be_empty
  end
end