require "bundler/setup"

Dir[
  "#{File.join(Gem.loaded_specs['dryad-core'].gem_dir, 'spec')}/**/*.rb"
].each {|f| require f}
