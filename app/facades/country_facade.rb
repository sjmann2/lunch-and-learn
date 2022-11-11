class CountryFacade
  def self.get_country
    response = CountryService.get_countries
    countries = response.map do |data|
      Country.new(data)
    end
    country = countries.sample
  end
end