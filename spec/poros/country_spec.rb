require 'rails_helper'

RSpec.describe Country do
  before :each do 
    @country = Country.new({name: "Afghanistan"})
  end

  it 'exists' do
    expect(@country).to be_a(Country)
  end

  it 'has a name' do
    expect(@country.name).to eq("Afghanistan")
  end
end