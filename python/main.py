import requests
import json


FROM = "204, Dr NS Hardikar Road, Sector 3E, New Delhi 110085, Delhi Sector 3E New Delhi India"

TO = "subash chowk, sonipat, haryana"
KEY = "LLEDFnRN3wCqmrEfLRrqCy1vE4eWwXgk"
MAX_ROUTES = 10

# https://www.latlong.net/Show-Latitude-Longitude.html

URL = f"http://www.mapquestapi.com/directions/v2/alternateroutes?key={KEY}&from={FROM}&to={TO}&maxRoutes={MAX_ROUTES}&timeOverage=100"

res = requests.get(URL)
# data = json.load(open("sample.json"))
data = res.json()
print(data.keys())


print(data["route"].keys())

print(data["route"]["maxRoutes"])

print(len(data["route"]["alternateRoutes"]))
