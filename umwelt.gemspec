# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'umwelt/version'

Gem::Specification.new do |spec|
  spec.name          = 'umwelt'
  spec.version       = Umwelt::VERSION
  spec.authors       = ['Oleg Sovetnik']
  spec.email         = ['sovetnik@oblaka.biz']

  spec.summary       = 'Umwelt is a client for umwelt.dev'
  spec.description   = <<~DESCRIPTION
    Umwelt is a domain architecture development(knowledge management) tool,
    for handy prototyping domain specification with code structure.
  DESCRIPTION
  spec.homepage      = 'http://umwelt.dev'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or
  # delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/sovetnik/umwelt'
    # spec.metadata["changelog_uri"] = "TODO:  CHANGELOG.md URL here."
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in
  # the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec)/}) }
  end
  spec.files += Dir['spec/examples/**/*']
  spec.bindir        = 'bin'
  spec.executables   = 'umwelt'
  spec.require_paths = ['lib']

  spec.add_dependency 'hanami-cli'
  spec.add_dependency 'httparty'
  spec.add_dependency 'unparser'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'fabrication'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'webmock'
end
