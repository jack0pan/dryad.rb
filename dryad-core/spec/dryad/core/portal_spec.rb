RSpec.describe Dryad::Core::Portal do
  it "creates with default options" do
    portal = Dryad::Core::Portal.new
    expect(portal.id).not_to be(nil)
    expect(portal.non_certifications).to eq([])
  end

  it "creates portals with different id" do
    portals = Array.new(100) { Dryad::Core::Portal.new }
    ids_set = portals.map{|portal| portal.id }.to_set
    expect(ids_set.count).to eq(portals.count)
  end
end
