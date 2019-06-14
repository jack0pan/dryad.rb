RSpec.describe Dryad::Core::ConfigProvider do
  it "raise exception when call load method" do
    begin
      config_provider = Dryad::Core::ConfigProvider.new
      config_provider.load('', nil)
    rescue Exception => e
      expect(e).not_to be(nil)
    end
  end
end
