#Gather user input for location
p "Where are you located?"
user_location_input = gets.chomp
p user_location_input

#Initialize variables for API keys
gmaps_key = ENV.fetch("GMAPS_KEY")
darksky_key = ENV.fetch("DARK_SKY_KEY")

#Initialize GMaps API, pull location data
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location_input}&key=#{gmaps_key}"

require("open-uri")
require("json")
gmaps_data_raw = URI.open(gmaps_url).read
gmaps_data = JSON.parse(gmaps_data_raw)
gmaps_array = gmaps_data["results"][0]
latitude = gmaps_array.fetch("geometry").fetch("location").fetch("lat")
longtitude = gmaps_array.fetch("geometry").fetch("location").fetch("lng") 

#Initialize Dark Sky API, pull weather data
darksky_url = "https://api.darksky.net/forecast/#{darksky_key}/#{latitude},#{longtitude}"

darksky_data_raw = URI.open(darksky_url).read
darksky_data = JSON.parse(darksky_data_raw)
p darksky_data.keys
#p darksky_data["currently"]
require "time"
require "date"
darksky_data_current = darksky_data["currently"]
time_current = darksky_data_current["time"]
time_current = Time.at(time_current)
time_zone = darksky_data["timezone"]
#time_current = time_current.in_time_zone(time_zone)
temp_current = darksky_data_current["temperature"]
weather_next_hour = darksky_data["minutely"]["summary"]

p "The current temperature is #{temp_current}F. The weather for the next hour is: #{weather_next_hour.downcase}"

darksky_data_hourly = darksky_data["hourly"]["data"]
$rain_counter = 0
12.times do |hour|
  precip_prob = darksky_data_hourly[hour]["precipProbability"]
  if precip_prob > 0.1
    p "There is a #{precip_prob} probability of rain #{hour} hours from now."
    $rain_counter = $rain_counter + 1
  end
end

if $rain_counter >= 1
  p "You might want to carry an umbrella"
else
  p "You probably won't need an umbrella today" 
end
