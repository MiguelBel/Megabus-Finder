require "spec_helper"

describe "URL constructor spec" do

  context "Load the data of the cities" do

    it "Load the JSON and get the first city of brussels" do
      initial_constructor = URLConstructor.new("Brussels")
      posible_destinations = initial_constructor.posible_destinations
      expect(posible_destinations.class).to be Hash
      expect(posible_destinations["cities_from"][0]["code"].to_i).to be 1
    end

  end

  context "Build the basic URL with correlation in depature city, arrival city, inbound date, outbound date (both dd-mm-yy)" do

    it "build a sample url" do
      depature_city_name = "Brussels" # Code is 112
      
      initial_constructor = URLConstructor.new(depature_city_name)

      arrival_city_name = initial_constructor.posible_destinations["cities_from"][0]["city_name"]
      arrival_city_code = initial_constructor.posible_destinations["cities_from"][0]["code"]

      outbound_date = "16-10-14"
      inbound_date = "20-10-14"

      expected_url = initial_constructor.buildBasicURL(arrival_city_code, outbound_date, inbound_date)

      expect(expected_url).to eq("http://eseu.megabus.com/JourneyResults.aspx?originCode=112&destinationCode=1&outboundDepartureDate=16%2f10%2f2014&inboundDepartureDate=20%2f10%2f2014&passengerCount=0&transportType=1&concessionCount=1&withReturn=1")
    end

    it "build url for all destinations" do
      depature_city_name = "Brussels" # Code is 112
      
      initial_constructor = URLConstructor.new(depature_city_name)

      arrival_city_name = initial_constructor.posible_destinations["cities_from"][0]["city_name"]
      arrival_city_code = initial_constructor.posible_destinations["cities_from"][0]["code"]

      outbound_date = "16-10-14"
      inbound_date = "20-10-14"

      mass_urls = initial_constructor.buildMassURL(outbound_date, inbound_date)

      expect(mass_urls.class).to be Hash
    end
  end

end