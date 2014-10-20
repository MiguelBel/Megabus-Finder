# Megabus Finder

Megabus Finder is a command line application for find the cheapest trips from one city given the outbound and inbound date.

I developed for my intereset so there is only three cities (the three cities of belgium where megabus has stop):

* Gent
* Brussels
* Antwerp

But feel free if you want to add more, is just add one json file to the data folder and edit the cities.json in the same folder.

## Usage

For use just use that command: (the dates should be like dd-mm-yy)

````
ruby megabus_finder.rb [origin_city] [oubound_date] [inbound_date]
````

You do not have to specify an inbound date if you do not do the inbound date will be the same as the outbound date
