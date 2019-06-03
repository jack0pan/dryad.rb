RSpec.describe Dryad do
  it "has a valid version number" do
    expect(Dryad::Core::VERSION).not_to be(nil)
  end

  it "can be configured with block" do
    consul_config = { host: "block.consul.example", port: 8500 }
    Dryad.configure do |config|
      config.consul = consul_config
    end

    expect(Dryad.configuration.consul).to eq(consul_config)
  end
end
