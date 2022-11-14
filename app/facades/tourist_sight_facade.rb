class TouristSightFacade
  def self.get_sights(country)
    require 'pry' ; binding.pry
    CountryService.get_countries
  end
end