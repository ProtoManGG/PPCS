import requests

lat_from = 28.9931
longi_from = 77.0151
lat_to = 28.7041
longi_to = 77.1025

def get_full_address(lat,longi):
    reverse_url = f"https://revgeocode.search.hereapi.com/v1/revgeocode?at={lat},{longi}&apikey=lFcSuhNtbp82mvji4vJh01hMloWyZScqhQkaAAgZ6Zs"
    res = requests.get(reverse_url)
    return res.json()["items"][0]["address"]["label"]

def clean_routes(shapePoints):
    route = []
    i=0
    while i<=len(shapePoints)-1:
        temp = []
        temp.append(shapePoints[i])
        temp.append(shapePoints[i+1])
        route.append(list(reversed(temp)))
        i+=2
    print(route)
    return route

KEY = "LLEDFnRN3wCqmrEfLRrqCy1vE4eWwXgk"
MAX_ROUTES = 10

# https://www.latlong.net/Show-Latitude-Longitude.html

URL = f"http://www.mapquestapi.com/directions/v2/alternateroutes?key={KEY}&from={get_full_address(lat_from, longi_from)}&to={get_full_address(lat_to, longi_to)}&maxRoutes={MAX_ROUTES}&timeOverage=1000"

res = requests.get(URL)
# data = json.load(open("sample.json"))
data = res.json()
print(data.keys())


print(data["route"].keys())

print(data["route"]["maxRoutes"])

print(len(data["route"]["alternateRoutes"]))

# json.dump(data,open('sonipat.json','w'))
print(data["route"]["alternateRoutes"][0]["route"]["boundingBox"])
clean_routes(data["route"]["alternateRoutes"][0]["route"]["shape"]["shapePoints"])





