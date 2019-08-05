RSpec.describe Dryad::Core::ServiceInstance do
  it 'can be created and access' do
    si = build(:service_instance)
    expect(si.name).to eq('rails')
    expect(si.schema).to eq(Dryad::Core::Schema::HTTP)
    expect(si.address).to eq('localhost')
    expect(si.port).to eq(3000)
  end
end
