RSpec.describe Dryad::Consul::ConfigProvider do
  before do
    @simple_config = build(:simple_config_data)
    stub_request(
      @simple_config.request_method,
      @simple_config.url
    ).with(
      headers: @simple_config.request_headers
    ).to_return(
      status: @simple_config.response_status,
      body: @simple_config.response_body
    )
  end

  it "load configuration with path" do
    cd = Dryad::Consul::ConfigProvider.instance.load(@simple_config.data_key)
    expect(cd.path).to eq(@simple_config.data_key)
    expect(cd.payload).to eq(@simple_config.data_value)
    expect(cd.version).to be > 0
  end
end
