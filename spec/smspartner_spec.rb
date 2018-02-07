RSpec.describe Smspartner do
  it 'has a version number' do
    expect(Smspartner::VERSION).not_to be nil
  end

  context 'tests setup' do
    it 'should have a secrets.yml file' do
      expect(File.exist?(File.expand_path('../secrets.yml', __FILE__))).to be(true)
    end
  end

  context 'with valid config' do
    let(:secrets) { YAML.load_file(File.expand_path('../secrets.yml', __FILE__)) }
    let(:api_key) { secrets[:api_key] }
    let(:phone_number) { secrets[:phone_number] }

    def configure!
      Smspartner.configure do |config|
        config.sandbox = true
        config.api_key = api_key
        config.sender  = 'RSpec'
      end
    end

    it 'should configure correctly' do
      expect { configure! }.not_to raise_error
      expect(Smspartner.client).not_to be_nil
    end

    it 'should be able to send a SMS' do
      configure!
      should respond_to(:send_sms)
      expect { subject.send_sms(to: phone_number, body: 'Test body') }.not_to raise_error
    end
  end
end
