RSpec.describe Dryad::Cluster::RoundRobin do
  before do
    @services = Array.new(10) {|index| index + 1}
    @round_robin = Dryad::Cluster::RoundRobin.new
  end

  it "set services and get service correctly" do
    @round_robin.set_services(@services)
    10.times do |i|
      expect(@round_robin.service).to eq(@services[(i + 1) % 10])
    end
  end

  it "raises no services error when services are empty" do
    begin
      @round_robin.service
    rescue StandardError => e
      expect(e.class).to eq(Dryad::Cluster::NoServicesError)
    end
  end
end
