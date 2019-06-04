RSpec.describe Dryad::Core do
  it "raise configuration not found error" do
    begin
      raise Dryad::Core::ConfigurationNotFound, "not found config file."
    rescue Dryad::Core::ConfigurationNotFound => e
      expect(e).not_to be(nil)
      expect(e.message).to eq("not found config file.")
    end
  end

  it "has a version number" do
    expect(Dryad::Core::VERSION).not_to be(nil)
  end
end
