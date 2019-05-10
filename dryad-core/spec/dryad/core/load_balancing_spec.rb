RSpec.describe Dryad::Core::LoadBalancing do
  it "values are correct" do
    expect(Dryad::Core::LoadBalancing::URL_HASH).to eq("url_chash")
    expect(Dryad::Core::LoadBalancing::ROUND_ROBIN).to eq("round_robin")
  end
end
