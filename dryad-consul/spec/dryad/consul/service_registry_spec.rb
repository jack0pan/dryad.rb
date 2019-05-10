RSpec.describe Dryad::Consul::ServiceRegistry do
  before do
    @portal = Dryad::Core::Portal.new(
      schema: Dryad::Core::Schema::HTTP,
      port: 3000,
      pattern: '/*',
      non_certifications: ['/*']
    )
    @service = Dryad::Core::Service.new(
      name: 'rails',
      address: '127.0.0.1',
      group: 'staging',
      portals: [@portal],
      priority: 10,
      load_balancing: [Dryad::Core::LoadBalancing::URL_HASH]
    )
  end

  it "gets the instances for a service" do
    Dryad::Consul::ServiceRegistry.register(@service)
    registers = @service.to_registers
    service_instances = Dryad::Consul::ServiceRegistry.service_instances(
      @service.name,
      Dryad::Core::Schema::HTTP,
      [@service.group]
    )
    expect(service_instances.count).to eq(registers.count)
    service_instances.zip(registers).each do |instance, register|
      expect(instance.name).to eq(register[:Name])
    end
    Dryad::Consul::ServiceRegistry.deregister(@service)
  end
end
