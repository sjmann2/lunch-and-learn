class User < ApplicationRecord
  has_many :favorites
  validates_presence_of :name, :email, :api_key
  validates_uniqueness_of :email, :api_key
  
  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end