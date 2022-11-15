class User < ApplicationRecord
  has_many :favorites
  validates_presence_of :name, :email, :password, :password_confirmation
  validates_uniqueness_of :email, :api_key
  
  has_secure_password
  
  before_validation :set_api_key, if: :api_key_nil?

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end

  def api_key_nil?
    self.api_key.nil?
  end

end