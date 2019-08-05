RSpec.describe Dryad::Core::Service do
  it "create with default options" do
    service = Dryad::Core::Service.new
    expect(service.type_name).to eq(Dryad::Core::Service::TYPE)
    expect(service.portals).to eq([])
    expect(service.load_balancing).to eq([])
  end

  it "create with options" do
    service = build(:service)
    expect(service.name).to eq("rails")
    expect(service.address).to eq("localhost")
    expect(service.portals.size).to eq(1)
  end
end
