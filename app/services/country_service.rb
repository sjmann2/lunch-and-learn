class CountryService
  def self.conn
    Faraday.new(url: "https://restcountries.com")
  end

  def self.get_countries
    Rails.cache.fetch("all-countries", expires_in: 1.month) do
      response = conn.get("/v2/all")
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end