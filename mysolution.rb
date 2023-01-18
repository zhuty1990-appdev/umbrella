p "Where are you located?"
user_location_input = gets.chomp
p user_location_input

gmaps_key = ENV.fetch("GMAPS_KEY")
dark_sky_key = ENV.fetch("DARK_SKY_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location_input}&key=#{gmaps_key}"

require("open-uri")
require("json")
gmaps_data_raw = open(gmaps_url).read
gmaps_data = JSON.parse(gmaps_data_raw)
gmaps_array = gmaps_data["results"][0]
latitude = gmaps_array.fetch("geometry").fetch("location").fetch("lat")
longtitude = gmaps_array.fetch("geometry").fetch("location").fetch("lng") 



p latitude
p longtitude
