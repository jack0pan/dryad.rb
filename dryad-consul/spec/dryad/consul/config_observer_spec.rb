RSpec.describe Dryad::Consul::ConfigObserver do
  it "raise exception when call update method" do
    config_desc = Dryad::Core::ConfigDesc.new('path', 'payload', 1)
    observer = Dryad::Consul::ConfigObserver.new
    begin
      observer.update(Time.now, config_desc, nil)
    rescue Exception => e
      expect(e).not_to be(nil)
    end
  end
end
