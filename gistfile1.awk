[akshay@nio my_library]$ cat dis.awk
# Author : Akshay Hegde
# http://www.unix.com/shell-programming-and-scripting/250356-geographical-distance-between-long-lat-bash.html
# Function to calculate the distance between two points

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


Usage :

1. On Terminal


[akshay@nio my_library]$ awk -f dis.awk --source 'BEGIN{ UNIT["M"]="Miles"; 
    UNIT["K"]="Kilometers"; UNIT["N"]="Nautical Miles"; 
    for(i in UNIT)print distance(32.9697, -96.80322, 29.46786, -98.53506, i),UNIT[i]}'
228.109 Nautical Miles
422.739 Kilometers
262.678 Miles


2. If you have text file something like this

[akshay@nio my_library]$ cat test.dat
32.9697 -96.80322 29.46786 -98.53506
31.9697 -97.80322 27.46786 -94.53506
27.9697 -91.80322 29.46786 -92.53506
34.9697 -93.80322 29.46786 -91.53506


You can use function like this

[akshay@nio my_library]$ cat test.awk
BEGIN{ 
	UNIT["M"]="Miles"; 
	UNIT["K"]="Kilometers"; 
	UNIT["N"]="Nautical Miles"; 
}
NF{  
	print $0;
	for(i in UNIT)
	{
		print distance($1, $2, $3, $4, i),UNIT[i]
	}
	print ""
}



[akshay@nio my_library]$ awk -f dis.awk -f test.awk test.dat 
32.9697 -96.80322 29.46786 -98.53506
228.109 Nautical Miles
422.739 Kilometers
262.678 Miles

31.9697 -97.80322 27.46786 -94.53506
319.252 Nautical Miles
591.647 Kilometers
367.633 Miles

27.9697 -91.80322 29.46786 -92.53506
97.7865 Nautical Miles
181.221 Kilometers
112.605 Miles

34.9697 -93.80322 29.46786 -91.53506
349.567 Nautical Miles
647.827 Kilometers
402.541 Miles