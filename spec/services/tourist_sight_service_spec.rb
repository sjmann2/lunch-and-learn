require 'rails_helper'

RSpec.describe TouristSightService do
  it 'returns an HTTP response of tourist sights within the given lat/long and radius', :vcr do
    response = TouristSightService.get_sights('2.0', '46.0')

    expect(response).to be_a(Hash)
    expect(response[:features]).to be_an(Array)
    sight = response[:features].first
    expect(sight[:properties][:name]).to be_a(String)
    expect(sight[:properties][:formatted]).to be_a(String)
    expect(sight[:properties][:place_id]).to be_a(String)
  end
end