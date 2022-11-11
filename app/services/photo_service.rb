class PhotoService
  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |faraday|
      faraday.params['client_id'] = ENV['unsplash_client_id']
    end
  end

  def self.get_photos(country)
    response = conn.get('search/photos') do |req|
      req.params['query'] = country
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end