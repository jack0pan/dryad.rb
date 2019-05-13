
version = File.read(File.expand_path("DRYAD_VERSION", __dir__)).strip

Gem::Specification.new do |spec|
  spec.name          = "dryad"
  spec.version       = version
  spec.authors       = ["Pan Jie"]
  spec.email         = ["panjie@growingio.com"]

  spec.summary       = %q{Config Management & Service Registration and Discovery}
  spec.description   = %q{Dryad is a configration management client. It provides functions such as hot loading of configuration files.}
  spec.homepage      = "https://github.com/jack0pan/dryad.rb"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_dependency "dryad-core", version
  spec.add_dependency "dryad-consul", version
  spec.add_dependency "dryad-cluster", version

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
