class PhotoFacade
  def self.get_photo(country)
    response = PhotoService.get_photo(country)
    response[:results].map do |data|
      Photo.new(data)
    end
  end
end