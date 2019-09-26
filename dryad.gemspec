
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dryad/version"

Gem::Specification.new do |spec|
  spec.name          = "dryad"
  spec.version       = Dryad::VERSION
  spec.authors       = ["Pan Jie"]
  spec.email         = ["panjie@growingio.com"]

  spec.summary       = %q{Config Management & Service Registration and Discovery}
  spec.description   = %q{Dryad is a configration management client. It provides functions such as hot loading of configuration files.}
  spec.homepage      = "https://github.com/jack0pan/dryad.rb"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|\w*-\w*)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dryad-core", Dryad::VERSION
  spec.add_dependency "dryad-consul", Dryad::VERSION
  spec.add_dependency "dryad-cluster", Dryad::VERSION

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_bot", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.6"
end
