RSpec.describe Dryad::Consul::ServiceClient do
  it "can get all services" do
    services = Dryad::Consul::ServiceClient.get_all()
    expect(services.consul.count).to be(0)
  end
end
