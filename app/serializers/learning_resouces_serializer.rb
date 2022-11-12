class LearningResoucesSerializer
  def self.format_resources(video, photos)
    {
      data: {
        id: nil,
        type: "learning_resource",
        attributes: {
          country: video.country,
          video: {
            title: video.title,
            youtube_video_id: video.youtube_video_id
          },
          images: photos.map do |photo|
            {
              alt_tag: photo.alt_tag,
              url: photo.url
            }
          end
        }
      }
    }
  end
end