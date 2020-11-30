require 'smspartner/version'
require 'smspartner/configurator'

module Smspartner
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

    def sms_status(**args)
      if client.nil?
        raise 'Initialization Error: You must call Smspartner.configure before calling sms_status'
      end
      client.sms_status(**args)
    end

    def account_data
      if client.nil?
        raise 'Initialization Error: You must call Smspartner.configure before calling account_data'
      end
      client.me
    end

  end
end
