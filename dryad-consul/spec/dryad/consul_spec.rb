RSpec.describe Dryad::Consul do
  it "has a version number" do
    expect(Dryad::Consul::VERSION).not_to be(nil)
  end

  it "has configured dependencies" do
    config = OpenStruct.new({ consul: { host: "127.0.0.1", port: 8500 } })
    Dryad::Consul.configure_consul(config)
    expect(::Diplomat.configuration.url).to eq("http://127.0.0.1:8500")
  end
end
