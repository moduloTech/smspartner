require 'smspartner/version'
require 'smspartner/configurator'

module Smspartner
  # Your code goes here...
  class << self

    def configure(&block)
      Configurator.configure(&block)
    end

    attr_accessor :configuration

    attr_accessor :client

    def send_sms(**args)
      if client.nil?
        raise 'Initialization Error: You must call Smspartner.configure before calling send_sms'
      end
      client.send_sms(**args)
    end

    def account_data
      if client.nil?
        raise 'Initialization Error: You must call Smspartner.configure before calling account_data'
      end
      client.me
    end

  end
end
