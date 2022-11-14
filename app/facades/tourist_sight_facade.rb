class TouristSightFacade
  def self.get_sights(country = (CountryFacade.get_country).name)
    country.gsub!(/\s+/, "%20")
    country = CountryService.get_country(country)
    latlng = country.first[:latlng]
    lon = latlng.last
    lat = latlng.first
    sights = TouristSightService.get_sights(lon, lat)
    sights[:features].map do |data|
      TouristSight.new(data)
    end
  end
end