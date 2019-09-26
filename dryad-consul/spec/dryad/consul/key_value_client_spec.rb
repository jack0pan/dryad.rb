RSpec.describe Dryad::Consul::KeyValueClient do
  it "gets value with index" do
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
    response = Dryad::Consul::KeyValueClient.get(@simple_config.data_key)
    expect(response.Value).to eq(@simple_config.data_value)
    expect(response.ModifyIndex).to be >= response.CreateIndex
  end

  it "gets value the key which is not existed" do
    @nil_config = build(:nil_config_data)
    stub_request(
      @nil_config.request_method,
      @nil_config.url
    ).with(
      headers: @nil_config.request_headers
    ).to_return(
      status: @nil_config.response_status,
      body: @nil_config.response_body
    )
    response = Dryad::Consul::KeyValueClient.get('key')
    expect(response).to be nil
  end
end
