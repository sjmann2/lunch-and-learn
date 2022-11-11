class VideoService
  def self.conn
    Faraday.new(url: "https://www.googleapis.com") do |faraday|
      faraday.params['key'] = ENV['youtube_api_key']
    end
  end

  def self.get_videos(country)
    response = conn.get("/youtube/v3/search") do |req|
      req.params['part'] = 'snippet'
      req.params['type'] = 'video'
      req.params['q'] = "#{country} history"
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end