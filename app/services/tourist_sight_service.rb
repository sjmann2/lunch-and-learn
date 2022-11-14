class TouristSightService
  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |faraday|
      faraday.params['apiKey'] = ENV['place_api_key']
    end
  end

  def self.get_sights(lon, lat)
    response = conn.get('/v2/places') do |req|
      req.params['categories'] = 'tourism.sights'
      req.params['filter'] = "circle:#{lon},#{lat},20000"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end