p "Where are you located?"

# user_location = gets.chomp

user_location = "Taj Mahal"

p user_location

require "open-uri"

gmaps_api_endpoint = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U"

# using_gsub = "https://maps.googleapis.com/maps/api/geocode/json?address=PLACEHOLDER&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U".gsub("PLACEHOLDER", user_location)

# using_interpolation = "https://maps.googleapis.com/maps/api/geocode/json?address=#{ user_location}&key=AIzaSyAgRzRHJZf-uoevSnYDTf08or8QFS_fb3U"

# p gmaps_api_endpoint

raw_data = URI.open(gmaps_api_endpoint).read

require "json"

parsed_data = JSON.parse(raw_data)

results_array = parsed_data.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

p latitude
p longitude

# Use latitude and longitude to compose the correct
#   endpoint in Dark Sky's API
# Print the current temperature
