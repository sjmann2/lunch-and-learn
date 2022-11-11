require 'rails_helper'

RSpec.describe VideoService do
  it 'returns an HTTP response of videos related to search term', :vcr do
    response = VideoService.get_videos('thailand')

    expect(response).to be_a(Hash)
    expect(response).to have_key(:items)
    video = response[:items].first
    expect(video[:id]).to have_key(:videoId)
    expect(video[:id][:videoId]).to be_a(String)
    expect(video[:snippet]).to have_key(:title)
    expect(video[:snippet][:title]).to be_a(String)
  end
end