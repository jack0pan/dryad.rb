RSpec.describe Dryad::Core::ConfigDesc do
  it "can be created and accessed" do
    cd = build(:config_desc)
    expect(cd.path).to eq('rails/config/database.yml')
    expect(cd.payload).not_to be(nil)
    expect(cd.version).to eq(1)
  end
end
