RSpec.describe Dryad::Core::Schema do
  it "has valid values" do
    expect(Dryad::Core::Schema::HTTP).to eq("http")
    expect(Dryad::Core::Schema::GRPC).to eq("grpc")
    expect(Dryad::Core::Schema::WEB_SOCKET).to eq("web-socket")
  end
end
