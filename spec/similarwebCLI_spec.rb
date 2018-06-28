RSpec.describe SimilarwebCLI do
  it "has a version number" do
    expect(SimilarwebCLI::VERSION).not_to be nil
  end

  context "during setup" do
    it "Has APi Key" do
      expect{SimilarwebCLI::Client.new}.not_to raise_error
    end
  end

  context "while calling the Traffic endpoint" do
    before(:all) do
      client = SimilarwebCLI::Client.new
      dStart = (Date.today - 60).strftime("%Y-%m")
      dEnd = (Date.today - 30).strftime("%Y-%m")
      @response = client.traffic("google.com",dStart,dEnd)
    end
    it "has a json result" do
      expect(@response.class).to be Hash
    end

    it "status in Meta is 'Success'" do
      expect(@response["meta"]["status"]).to eq "Success"
    end

    it "Data to contain over 25 days" do
      expect(@response["visits"].size).to be > 25
    end
  end

end
