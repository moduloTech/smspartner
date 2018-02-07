require 'smspartner/helpers/boolean'

module Smspartner
  class Configuration

    ALLOWED_RANGE_VALUES = %i[premium low_cost].freeze

    # @param api_key [String] the API key
    # @param range_value [:premium, :low_cost]
    # @param sandbox [Boolean] true to enable sandbox mode, disabled by default
    # @param sender [String] SMS sender's name
    def initialize(api_key:, range_value:, sandbox: false, sender: nil)
      self.api_key     = api_key
      self.range_value = range_value
      self.sandbox     = sandbox
      self.sender      = sender
    end

    # @return [Hash] attributes as a hash
    def to_h
      {
        api_key:     api_key,
        range_value: range_value,
        sandbox:     sandbox,
        sender:      sender
      }
    end

    attr_reader :api_key

    private

    attr_writer   :api_key
    attr_accessor :sender

    attr_reader :range_value
    def range_value=(value)
      unless ALLOWED_RANGE_VALUES.include?(value)
        raise ArgumentError.new(
          "#{value.inspect} is not a valid range_value, " \
          "valid values are #{ALLOWED_RANGE_VALUES.inspect}"
        )
      end
      @range_value = value
    end

    attr_reader :sandbox
    def sandbox=(bool)
      unless Helpers::Boolean.valid?(bool)
        raise ArgumentError.new(
          "#{bool.inspect} should be a boolean"
        )
      end
      @sandbox = bool
    end

  end
end
