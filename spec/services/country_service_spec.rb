require 'rails_helper'

RSpec.describe CountryService do
  it 'returns an HTTP response of country names', :vcr do
    countries = CountryService.get_countries

    expect(countries).to be_an(Array)
    expect(countries.first).to be_a(Hash)
    expect(countries.first[:name]).to be_a(String)
  end
end