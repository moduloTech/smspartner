require 'httparty'
require 'smspartner/response'

module Smspartner
  class Client

    def initialize(config)
      @config = config
    end

    SEND_SMS_URL = 'https://api.smspartner.fr/v1/send'.freeze

    SMS_STATUS_URL = 'https://api.smspartner.fr/v1/message-status'.freeze

    MY_DATA_URL = 'https://api.smspartner.fr/v1/me'.freeze

    ALLOWED_CONFIG_OVERRIDE = %i[sandbox sender range_value].freeze

    RANGE_VALUES = { premium: 1, low_cost: 2 }.freeze

    # @param to     [String] phone number
    # @param body   [String] SMS body
    # @param config [Hash]   overrides to config
    def send_sms(to:, body:, **config)
      res = send_request(to, body, config)
      ret = Response.new(res.parsed_response)
      raise SmsSendError.new(ret) if !ret.success? && config[:raise_on_error]
      ret
    end

    def sms_status(to:, message_id:, **config)
      res = status_request(to, message_id, config)
      ret = Response.new(res.parsed_response)
      raise SmsStatusError.new(ret) if !ret.success? && config[:raise_on_error]
      ret
    end

    def me
      HTTParty.get(
        MY_DATA_URL,
        query:   {
          apiKey: @config.api_key
        },
        headers: {
          content_type: 'application/json'
        }
      ).parsed_response
    end

    private

    def send_request(to, body, config)
      HTTParty.post(
        SEND_SMS_URL,
        body:    sms_json(
          to,
          body,
          config.select { |k, _v| ALLOWED_CONFIG_OVERRIDE.include?(k) }.compact
        ).to_json,
        headers: {
          content_type: 'application/json'
        }
      )
    end

    def status_request(to, message_id, config)
      final_config = @config.to_h.merge!(config)
      HTTParty.get(
        SMS_STATUS_URL,
        query: {
          phoneNumber: to,
          messageId:   message_id,
          apiKey:      final_config[:api_key]
        }
      )
    end

    def sms_json(to, body, config)
      final_config = @config.to_h.merge!(config)

      json = {
        apiKey:       final_config[:api_key],
        message:      body,
        phoneNumbers: to,
        gamme:        RANGE_VALUES[final_config[:range_value]],
        sender:       final_config[:sender]
      }
      json.compact!
      json[:sandbox] = 1 if final_config[:sandbox]

      json
    end

  end
end
