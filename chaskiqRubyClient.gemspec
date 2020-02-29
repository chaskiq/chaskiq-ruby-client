
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "chaskiqRubyClient/version"

Gem::Specification.new do |spec|
  spec.name          = "chaskiq-client"
  spec.version       = ChaskiqRubyClient::VERSION
  spec.authors       = ["michelson"]
  spec.email         = ["miguel@chaskiq.io"]

  spec.summary       = %q{Chaskiq.io ruby gem}
  spec.description   = %q{Chaskiq ruby gem interacts with chaskiq.io api}
  spec.homepage      = "https://github.io/chaskiq/chaskiq-ruby-client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "'http://rubygems.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "jwe"
  spec.add_dependency "activesupport"
  spec.add_dependency "oauth2"
  spec.add_dependency "thor"
  spec.add_dependency "graphlient", "0.3.5"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
