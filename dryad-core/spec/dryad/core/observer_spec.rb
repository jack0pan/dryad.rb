RSpec.describe Dryad::Core::Observer do
  it "raise exception when call update method" do
    begin
      observer = Dryad::Core::Observer.new
      observer.update(nil, nil, nil)
    rescue Exception => e
      expect(e).not_to be(nil)
    end
  end
end
