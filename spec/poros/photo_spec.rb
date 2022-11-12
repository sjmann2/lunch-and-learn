require 'rails_helper'

RSpec.describe Photo do
  before :each do 
    @photo = Photo.new(
      {alt_description: "standing statue and temples landmark during daytime",
            urls: {
                raw: "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzk5ODB8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyMDQ5MjA&ixlib=rb-4.0.3"}})
  end

  it 'exists' do
    expect(@photo).to be_a(Photo)
  end

  it 'has a url and a alt tag' do
    expect(@photo.url).to eq("https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzk5ODB8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2NjgyMDQ5MjA&ixlib=rb-4.0.3")
    expect(@photo.alt_tag).to eq("standing statue and temples landmark during daytime")
  end
end