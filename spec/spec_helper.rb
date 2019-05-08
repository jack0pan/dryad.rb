require "bundler/setup"
require "#{File.join(Gem.loaded_specs['dryad-core'].gem_dir, 'spec')}/spec_helper.rb"

Dir[
  "#{File.join(Gem.loaded_specs['dryad-core'].gem_dir, 'spec')}/**/*_spec.rb"
].each {|f| require f}
