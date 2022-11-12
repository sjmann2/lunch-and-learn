class PhotoFacade
  def self.get_photos(country)
    response = PhotoService.get_photos(country)
    response[:results].map do |data|
      Photo.new(data)
    end
  end
end