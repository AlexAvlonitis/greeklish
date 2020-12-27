lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "greeklish/version"

Gem::Specification.new do |spec|
  spec.name          = "greeklish"
  spec.version       = Greeklish::VERSION
  spec.authors       = ["Alex"]
  spec.email         = ["avlonitis@msn.com"]

  spec.summary       = %q{Converts greeklish to greek}
  spec.description   = %q{Converts greek words written with english/latin characters, to proper greek words with greek alphabet, and does spell checking as a bonus.}
  spec.homepage      = "https://github.com/alexavlonitis/greeklish"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.glob('{bin, lib, config}/**/*') + %w[README.md]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_dependency "i18n"
end
