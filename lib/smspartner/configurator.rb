require 'smspartner/configuration'
require 'smspartner/client'

module Smspartner
  # Configuration builder that is yielded by Smspartner.configure
  class Configurator

    def self.configure
      raise ArgumentError.new('A block is needed for Smspartner.configure') unless block_given?
      builder = new
      yield builder
      Smspartner.configuration = builder.build_config
      Smspartner.client = Client.new(Smspartner.configuration)
    end

    def initialize
      @range_value = :premium
      @sandbox = false
    end

    def build_config
      Configuration.new(
        api_key:     api_key,
        sender:      sender,
        range_value: range_value,
        sandbox:     sandbox
      )
    end

    attr_accessor :api_key, :sender, :range_value, :sandbox

  end

  private_constant :Configurator
end
