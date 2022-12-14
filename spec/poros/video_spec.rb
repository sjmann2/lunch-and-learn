require 'rails_helper'

RSpec.describe Video do
  before :each do
    @video = Video.new({id: {videoId: "zo1e7XUWkME"}, snippet: {title: "THE HISTORY OF THAILAND in 10 minutes"}, country: 'laos'})
  end

  it 'exists' do
    expect(@video).to be_a(Video)
  end

  it 'has a title, a video id, and a country' do
    expect(@video.title).to eq("THE HISTORY OF THAILAND in 10 minutes")
    expect(@video.youtube_video_id).to eq("zo1e7XUWkME")
    expect(@video.country).to eq('laos')
  end
end