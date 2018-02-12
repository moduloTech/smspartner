
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smspartner/version'

Gem::Specification.new do |spec|
  spec.name          = 'smspartner'
  spec.version       = Smspartner::VERSION
  spec.authors       = ['Jean-Baptiste Brenaut']
  spec.email         = ['jbrenaut@modulotech.fr']

  spec.summary       = %q(Ruby interface to https://www.smspartner.fr)
  spec.description   = %q(Ruby interface to https://www.smspartner.fr's API)
  spec.homepage      = 'https://www.smspartner.fr/'
  spec.source        = 'https://github.com/moduloTech/smspartner'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against ' \
  #     'public gem pushes.'
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.50'
end
