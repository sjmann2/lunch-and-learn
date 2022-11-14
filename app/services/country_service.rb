class CountryService
  def self.conn
    Faraday.new(url: "https://restcountries.com")
  end

  def self.get_countries
    response = conn.get("/v2/all")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_country(country)
    response = conn.get("/v2/name/#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
end