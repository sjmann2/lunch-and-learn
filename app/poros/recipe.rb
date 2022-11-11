class Recipe
  attr_reader :title,
              :url,
              :image,
              :id,
              :country

  def initialize(data)
    @id = nil.to_json
    @title = data[:recipe][:label]
    @url = data[:recipe][:uri]
    @image = data[:recipe][:image]
    @country = data[:q]
  end
end