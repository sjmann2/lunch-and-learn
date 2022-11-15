require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :favorites }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_uniqueness_of :api_key }
    it { should validate_presence_of :password}
  end

  describe 'callbacks' do
    it 'gets assigned an api key when created' do
      user = User.create(name: "Jim", email: "jimmy@beans.com")
      expect(user.api_key).to_not be_nil
    end
  end
end