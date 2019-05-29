RSpec.describe Dryad::Consul::ConfigProvider do
  before do
    @key = "path/of/key"
    @value = "value of key"
    ::Diplomat::Kv.put(@key, @value)
  end

  after do
    ::Diplomat::Kv.delete(@key)
  end

  it "load configuration with path" do
    cd = Dryad::Consul::ConfigProvider.load(@key)
    expect(cd.path).to eq(@key)
    expect(cd.payload).to eq(@value)
    expect(cd.version).to be > 0
  end
end
