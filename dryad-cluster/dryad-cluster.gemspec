
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dryad/cluster/version"

Gem::Specification.new do |spec|
  spec.name          = "dryad-cluster"
  spec.version       = Dryad::Cluster::VERSION
  spec.authors       = ["Pan Jie"]
  spec.email         = ["panjie@growingio.com"]

  spec.summary       = %q{Dryad cluster library.}
  spec.description   = %q{Use cluster for service discovery. Use round robin to process scheduling.}
  spec.homepage      = "https://github.com/jack0pan/dryad.rb"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "dryad-core", Dryad::Cluster::VERSION
  spec.add_dependency "concurrent-ruby", "~> 1.1", ">= 1.1.5"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
