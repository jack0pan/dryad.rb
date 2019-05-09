RSpec.describe Dryad::Consul do
  it "has a version number" do
    version = File.read(File.expand_path("../../../DRYAD_VERSION", __dir__)).strip
    expect(Dryad::Consul::VERSION).to eq(version)
  end

  it "has configured dependencies" do
    expect(::Diplomat.configuration.url).to eq("http://file.consul.example:8500")
  end
end
