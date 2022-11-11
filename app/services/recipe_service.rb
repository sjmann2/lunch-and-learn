class RecipeService
  def self.conn
    Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params['app_id'] = ENV['edmam_app_id']
      faraday.params['app_key'] = ENV['edmam_api_key']
    end
  end

  def self.get_recipes(keyword)
    response = conn.get('/search') do |req|
      req.params['q'] = keyword
      req.params['count'] = 10
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end