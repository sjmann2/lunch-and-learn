class VideoFacade
  def self.get_video(country)
    response = VideoService.get_videos(country)
    videos = response[:items].map do |video|
      data = video.merge(country: country)
      Video.new(data)
    end
    videos.first
  end
end