class Video
  attr_reader :title,
              :youtube_video_id,
              :country
              
  def initialize(data)
    @title = data[:snippet][:title]
    @youtube_video_id = data[:id][:videoId]
    @country = data[:country]
  end
end