module Smspartner
  class Response

    def initialize(body)
      @success    = body['success']
      @errors     = body['error']
      @code       = body['code']
      @message_id = body['message_id']
      @raw_data   = body
    end

    def success?
      @success
    end

    attr_reader :errors
    attr_reader :code
    attr_reader :message_id
    attr_reader :raw_data

  end
end
