# Function to calculate the distance between two points
# Author : Akshay Hegde
# http://www.unix.com/shell-programming-and-scripting/250356-geographical-distance-between-long-lat-bash.html


function atan(x) { return atan2(x,1) }
function acos(x) { return atan2(sqrt(1-x*x), x) }
function deg2rad(Deg){ return ( 4.0*atan(1.0)/180 ) * Deg }
function rad2deg(Rad){ return ( 45.0/atan(1.0) ) * Rad }

# Distance(lat1,lon1,lat2,lon2,unit)
     
#    lat1, lon1 = Latitude and Longitude of point 1 (in decimal degrees)  
#    lat2, lon2 = Latitude and Longitude of point 2 (in decimal degrees)  

#    If 4th argument is not found then it returns distance in Miles
     
# -------  Units ----------
#   "M" -> Miles (default) 
#   "K" -> Kilometers
#   "N" -> Nautical Miles

function distance(lat1, lon1, lat2, lon2, unit) {
  theta = lon1 - lon2
  dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +  cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
  dist = acos(dist)
  dist = rad2deg(dist)
  miles = dist * 60 * 1.1515
  unit = toupper(unit)
  return ( unit == "K" ) ? (miles * 1.609344) : (unit == "N") ? ( miles * 0.8684) : miles
}


