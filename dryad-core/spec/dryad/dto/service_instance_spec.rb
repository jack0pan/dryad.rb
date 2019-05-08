RSpec.describe Dryad::DTO::ServiceInstance do
  it 'can be created and access' do
    si = Dryad::DTO::ServiceInstance.new(name: 'grpc-service', schema: 'grpc', address: 'localhost', port: 19000)
    expect(si.name).to eq('grpc-service')
    expect(si.schema).to eq('grpc')
  end
end
