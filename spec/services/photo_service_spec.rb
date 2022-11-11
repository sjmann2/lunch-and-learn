require 'rails_helper'

RSpec.describe PhotoService do
  it 'returns an HTTP response of photos related to the search term', :vcr do
    response = PhotoService.get_photos('thailand')

    expect(response).to be_a(Hash)
    expect(response[:results]).to be_an(Array)
    expect(response[:results].count).to eq(10)
    photos = response[:results].first
    expect(photos[:alt_description]).to be_a(String)
    expect(photos[:urls][:raw]).to be_a(String)
  end
end