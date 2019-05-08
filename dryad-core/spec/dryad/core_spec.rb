RSpec.describe Dryad::Core do
  it "has a version number" do
    version = File.read(File.expand_path("../../../DRYAD_VERSION", __dir__)).strip
    expect(Dryad::Core::VERSION).to eq(version)
  end
end
