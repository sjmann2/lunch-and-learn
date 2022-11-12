class ErrorSerializer
  attr_reader :message,
              :status,
              :code

  def initialize(message, status, code)
    @message = message
    @status = status
    @code = code
  end

  def serialized_message
    {
      errors: [
        {
          status: @status,
          message: @message,
          code: @code
        }
      ]
    }
  end
end