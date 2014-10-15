require "pp"
require "curb"
require "nokogiri"
require "rspec"
require "json"

require_relative '../lib/url_constructor'
require_relative '../lib/petitions_manager'

def getBasicURL
  depature_city_name = "Brussels" # Code is 112
  
  initial_constructor = URLConstructor.new(depature_city_name)

  arrival_city_name = initial_constructor.posible_destinations["cities_from"][0]["city_name"]
  arrival_city_code = initial_constructor.posible_destinations["cities_from"][0]["code"]

  outbound_date = getFutureDate(1)
  inbound_date = getFutureDate(3)

  base_url = initial_constructor.buildBasicURL(arrival_city_code, outbound_date, inbound_date)
end

def getFutureDate(days)
  tomorrow = Time.at(Time.now.to_i + 86400 * days)
  day = tomorrow.day.to_s
  month = tomorrow.month.to_s
  year = Time.at(Time.now.to_i + 86400).year.to_s[2..4]

  return "#{day}-#{month}-#{year}"
end