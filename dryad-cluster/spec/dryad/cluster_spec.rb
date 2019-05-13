RSpec.describe Dryad::Cluster do
  before do
    @portal = Dryad::Core::Portal.new(
      schema: Dryad::Core::Schema::HTTP,
      port: 3000,
      pattern: '/*',
      non_certifications: ['/*']
    )
    @service = Dryad::Consul::Service.new(
      name: 'rails',
      address: '127.0.0.1',
      group: 'staging',
      portals: [@portal],
      priority: 10,
      load_balancing: [Dryad::Core::LoadBalancing::URL_HASH]
    )
  end

  it "has a version number" do
    expect(Dryad::Cluster::VERSION).not_to be nil
  end

  it "rounds robin" do
    Dryad::Consul::ServiceRegistry.register(@service)
    service_instance = Dryad::Cluster.round_robin(
      Dryad::Core::Schema::HTTP,
      @service.name
    )
    expect(service_instance.name).to eq(@service.name)
    expect(service_instance.address).to eq(@service.address)
    Dryad::Consul::ServiceRegistry.deregister(@service)
  end
end
