RSpec.describe Dryad::Core::ConfigDesc do
  it "can be created and accessed" do
    path = 'path/to/key'
    payload = 'payload for path'
    version = 1
    cd = Dryad::Core::ConfigDesc.new(path, payload, version)
    expect(cd.path).to eq(path)
    expect(cd.payload).to eq(payload)
    expect(cd.version).to eq(version)
  end
end
