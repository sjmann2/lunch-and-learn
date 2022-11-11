class CountryFacade
  def self.get_countries
    response = CountryService.get_countries
    response.map do |data|
      Country.new(data)
    end
  end
end