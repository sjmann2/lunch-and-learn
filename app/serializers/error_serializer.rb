class ErrorSerializer
  attr_reader :error,
              :status,
              :code

  def initialize(error, status, code)
    @error = error
    @status = status
    @code = code
  end

  def serialized_message
    {
      errors: [
        {
          status: @status,
          message: @error,
          code: @code
        }
      ]
    }
  end
end