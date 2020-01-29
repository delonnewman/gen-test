lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gen/test/version"

Gem::Specification.new do |spec|
  spec.name          = "gen-test"
  spec.version       = Gen::Test::VERSION
  spec.authors       = ["Delon Newman"]
  spec.email         = ["contact@delonnewman.name"]

  spec.summary       = %q{Generative / Property testing}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/delonnewman/gen-test"
  spec.license       = "MIT"

  spec.metadata["allowed_push_host"] = 'https://rubygems.org'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}#changelog"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/gen-test"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faker", "~> 1.9.6"
  spec.add_runtime_dependency "regexp-examples", "~> 1.5.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard", "~> 0.9.24"
end
