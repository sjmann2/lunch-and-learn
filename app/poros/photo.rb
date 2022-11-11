class Photo
  attr_reader :url, 
              :alt_tag

  def initialize(data)
    @url = data[:urls][:raw]
    @alt_tag = data[:alt_description]
  end
end