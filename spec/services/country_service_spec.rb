require 'rails_helper'

RSpec.describe CountryService do
  it 'returns an HTTP response of country names', :vcr do
    countries = CountryService.get_countries

    expect(countries).to be_an(Array)
    expect(countries.first).to be_a(Hash)
    expect(countries.first[:name]).to be_a(String)
  end

  it 'returns an HTTP response of information about a given country', :vcr do
    country = CountryService.get_country('France')

    expect(country).to be_an(Array)
    expect(country.first[:name]).to be_a(String)
    expect(country.first[:latlng]).to be_an(Array)
  end
end