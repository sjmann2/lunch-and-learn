class VideoFacade
  def self.get_videos(country)
    response = VideoService.get_videos(country)
    response[:items].map do |data|
      Video.new(data)
    end
  end
end