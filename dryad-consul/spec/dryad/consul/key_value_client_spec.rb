RSpec.describe Dryad::Consul::KeyValueClient do
  before do
    @key = "path/of/key"
    @value = "value of key"
    ::Diplomat::Kv.put(@key, @value)
  end

  after do
    ::Diplomat::Kv.delete(@key)
  end

  it "gets value with index" do
    response = Dryad::Consul::KeyValueClient.get(@key)
    expect(response.Value).to eq(@value)
    expect(response.ModifyIndex).to be >= response.CreateIndex
  end

  it "gets value the key which is not existed" do
    response = Dryad::Consul::KeyValueClient.get('key')
    expect(response).to be nil
  end
end
