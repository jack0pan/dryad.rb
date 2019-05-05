RSpec.describe Dryad do
  it "has a valid version number" do
    expect(Dryad::VERSION).to eq('0.1.0')
  end

  it "can be configured with config file" do
    environment = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "default"
    default_consul_config = YAML.load(ERB.new(File.read(ENV['DRYAD_CONFIG_FILE'])).result)[environment]["consul"]
    expect(Dryad.configuration.consul[:host]).to eq(default_consul_config["host"])
    expect(Dryad.configuration.consul[:port]).to eq(default_consul_config["port"])
  end

  it "can be configured with block" do
    consul_config = { host: "block.consul.example", port: 8500 }
    Dryad.configure do |config|
      config.consul = consul_config
    end

    expect(Dryad.configuration.consul).to eq(consul_config)
  end
end
