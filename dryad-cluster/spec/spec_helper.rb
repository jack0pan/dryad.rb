ENV['DRYAD_CONFIG_FILE'] = File.expand_path("dummy/config/dryad.yml", __dir__)

require "bundler/setup"
require "dryad"
require "dryad/consul"
require "dryad/cluster"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end