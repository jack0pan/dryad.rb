RSpec.describe Dryad::Consul::Service do
  before do
    @portal = Dryad::Core::Portal.new(
      schema: Dryad::Core::Schema::HTTP,
      port: 3000,
      pattern: '/*',
      non_certifications: ['/*']
    )
    @service = Dryad::Consul::Service.new(
      name: 'http-service',
      address: '127.0.0.1',
      group: 'staging',
      portals: [@portal],
      priority: 10,
      load_balancing: [Dryad::Core::LoadBalancing::URL_HASH]
    )
  end

  it "gets all registers" do
    registers = @service.to_registers
    expect(registers.count).to eq(@service.portals.count)
  end
end
