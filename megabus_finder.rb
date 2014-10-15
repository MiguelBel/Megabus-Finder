require "pp"
require "curb"
require "nokogiri"
require "rspec"
require "json"

require_relative 'lib/url_constructor'
require_relative 'lib/petitions_manager'

# Arguments of the script
outbound_date = ARGV[1] 
inbound_date = ARGV[2]
depature_city = ARGV[0]

# Basic checkup
inbound_date = outbound_date if inbound_date.nil?

# Cities avaliable
cities = JSON.parse(File.read('data/cities.json'))["cities"]
check_cities = []
cities.each{|city| check_cities.push(city["city_name"].downcase)}

if !check_cities.include?(depature_city.downcase) || outbound_date.nil? || inbound_date.nil?
  pp "Wrong city"
  exit
end

url_constructor = URLConstructor.new(depature_city)

cheapest_array = []

all_urls = url_constructor.buildMassURL(outbound_date, inbound_date)

all_urls["urls"].each do |trip|
  single_petition_manager = PetitionManager.new(trip["url"].to_s)
  prices = single_petition_manager.get_prices
  cheapest_combination = single_petition_manager.find_cheapest_combination
  
  # Show
  pp "Prices list from #{depature_city} to #{trip["city_name"].to_s} going on #{outbound_date} and coming on #{inbound_date}"
  pp "Outbound date: #{prices["outbound"]} y Precios de vuelta #{prices["inbound"]}"
  pp "Cheapest combination: #{cheapest_combination}"
  pp "------------------"

  cheapest_array.push({:from => depature_city, :to => trip["city_name"], :price => cheapest_combination}) if !cheapest_combination.nil?
end

ordered_cheapest_array = cheapest_array.sort_by { |hsh| hsh[:price] }

ordered_cheapest_array.each do |each_destination|
  pp "From #{depature_city} to #{each_destination[:to]} (#{outbound_date} | #{inbound_date}) for #{each_destination[:price]} EURO"
end