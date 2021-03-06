require "spec_helper"

describe "Tests of the petitions manager" do

  context "Get the samples prices" do
    
    it "Get the prices of the url (the trip I mean)" do
      basic_url = getBasicURL
      petition_manager = PetitionManager.new(basic_url)
      prices = petition_manager.get_prices
      expect(prices.class).to be Hash
      expect(prices["outbound"].count).to be > 0
      expect(prices["inbound"].count).to be > 0

      expect(prices["outbound"][0].class).to be Fixnum
      expect(prices["inbound"][0].class).to be Fixnum
    end
  
  end

end 