require "net/http"

class PetitionManager

  def initialize(url)
    unless url.class == Array
      @parsed_content = Nokogiri::HTML(Net::HTTP.get(URI.parse(url)))
    end
  end

  def get_prices
    outbound = []
    inbound = []

    @parsed_content.search(".JourneyList").each_with_index do |route, index|
      route.search(".journey.standard").each do |single_route|
        if index == 0
          outbound.push(single_route.search(".five").text.strip.to_i)
        else
          inbound.push(single_route.search(".five").text.strip.to_i)
        end
      end
    end

    prices = {"outbound" => outbound, "inbound" => inbound}

    return prices
  end

  def find_cheapest_combination
    combinations = []

    self.get_prices["outbound"].each do |first_array_prices|
      self.get_prices["inbound"].each do |second_array_prices|
        combinations.push(first_array_prices + second_array_prices)
      end
    end

    return combinations.sort.first
  end

end