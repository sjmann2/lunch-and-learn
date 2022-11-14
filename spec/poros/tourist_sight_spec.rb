require 'rails_helper'

RSpec.describe TouristSight do
  before :each do
    @tourist_sight = TouristSight.new(
      {properties: 
        {name: "Tour de l'horloge", 
        formatted: "Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France", 
        place_id: "51d28de2694b5901405998a9a0ad8afa4640f00102f901db2e6f0d00000000920311546f7572206465206c27686f726c6f6765"}})
  end

  it 'exists' do
    expect(@tourist_sight).to be_a(TouristSight)
  end

  it 'has a name, address, and place_id' do
    expect(@tourist_sight.name).to eq("Tour de l'horloge")
    expect(@tourist_sight.address).to eq("Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France")
    expect(@tourist_sight.place_id).to eq("51d28de2694b5901405998a9a0ad8afa4640f00102f901db2e6f0d00000000920311546f7572206465206c27686f726c6f6765")
  end
end