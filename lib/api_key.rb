module ApiKey
  def self.generator
    SecureRandom.hex(27)
  end
end