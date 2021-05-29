import requests
headers = {
    'Accept': 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
    }
KEY_ORS="5b3ce3597851110001cf62489c708b292d2e4547a7742c6cd864245e"
def getCoords(address):
    req = requests.get(f"https://api.openrouteservice.org/geocode/search?api_key={KEY_ORS}&text={address}")
    RES = req.json()["features"][0]["geometry"]["coordinates"]
    return RES[0],RES[1]
longi_from,lat_from = getCoords("delhi")
longi_to,lat_to = getCoords("saini punjabi dhaba")
call = requests.get(f'https://api.openrouteservice.org/v2/directions/driving-car?api_key={KEY_ORS}&start={longi_from},{lat_from}&end={longi_to},{lat_to}', headers=headers)


res=call.json()
print(res)
