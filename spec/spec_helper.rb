require "bundler/setup"
require "#{File.join(Gem.loaded_specs['dryad-core'].gem_dir, 'spec')}/spec_helper.rb"
require "#{File.join(Gem.loaded_specs['dryad-consul'].gem_dir, 'spec')}/spec_helper.rb"
require "#{File.join(Gem.loaded_specs['dryad-cluster'].gem_dir, 'spec')}/spec_helper.rb"

Dir[
  "#{File.join(Gem.loaded_specs['dryad-core'].gem_dir, 'spec')}/**/*_spec.rb",
  "#{File.join(Gem.loaded_specs['dryad-consul'].gem_dir, 'spec')}/**/*_spec.rb",
  "#{File.join(Gem.loaded_specs['dryad-cluster'].gem_dir, 'spec')}/**/*_spec.rb"
].each {|f| require f}
