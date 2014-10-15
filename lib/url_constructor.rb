class URLConstructor

  def initialize(initial_city)
    cities = JSON.parse(File.read('data/cities.json'))["cities"]

    cities.each do |city|
      if city["city_name"].downcase == initial_city.downcase
        @content = File.read("data/#{city['file_name']}.json")
        @code = city["city_code"]
      end
    end

    @posible_destinations = JSON.parse(@content)
  end

  def posible_destinations
    return @posible_destinations
  end

  def buildBasicURL(arrival_city_code, outbound_date, inbound_date)
    # Parse outbound dte
    outbound_date = outbound_date.split('-')
    inbound_date = inbound_date.split('-')

    return "http://eseu.megabus.com/JourneyResults.aspx?originCode=#{@code}&destinationCode=#{arrival_city_code}&outboundDepartureDate=#{outbound_date[0]}%2f#{outbound_date[1]}%2f20#{outbound_date[2]}&inboundDepartureDate=#{inbound_date[0]}%2f#{inbound_date[1]}%2f20#{inbound_date[2]}&passengerCount=0&transportType=1&concessionCount=1&withReturn=1"
  end

  def buildMassURL(outbound_date, inbound_date)
    destinations_urls = []

    @posible_destinations["cities_from"].each do |single_destination| 
      destinations_urls.push({"city_code" => single_destination["code"], "city_name" => single_destination["city_name"], "url" => self.buildBasicURL(single_destination["code"], outbound_date, inbound_date)})
    end

    return {"urls" => destinations_urls}
  end

end