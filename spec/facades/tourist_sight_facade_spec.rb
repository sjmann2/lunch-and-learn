require 'rails_helper'

RSpec.describe TouristSightFacade do
  it 'returns tourist sight objects for the given country', :vcr do
    response = TouristSightFacade.get_sights('France')

    expect(response).to be_an(Array)
    expect(response.first).to be_a(TouristSight)
  end
end