
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
      lastMonth = Date.today.prev_month.strftime("%Y-%m")
      @response = client.traffic("google.com",lastMonth,lastMonth)
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

  context "while using the cli" do
    context "traffic endpoint" do
      it "fails with no domain" do
        output = `ruby bin/sw traffic`
        expect(output).to match(/no domain specified/)
      end
      it "prints debug information" do
        output = `ruby bin/sw traffic -d eyeo.com --debug`
        expect(output).to match(/eyeo.com/)
      end
      it "works with a domain that has no data" do
        output = `ruby bin/sw traffic -d eyeoithebestthingever.com`
        expect(output).to match(/Data not found/)
      end
      it "prints the head data only" do
        output = `ruby bin/sw traffic -d eyeo.com --head`
        expect(output).to match(/'visits'/)
      end
      it "returns the raw json response" do
        output = `ruby bin/sw traffic -d eyeo.com --json`
        expect(JSON.parse(output).class).to be(Hash) #json parses correctly to Hash
      end
    end

  end

end
