from fastapi import FastAPI
from pydantic import BaseModel
import json
import uvicorn
import psycopg2
# import reverse_geocoder as rg
connection = psycopg2.connect(host="localhost", port=5432,
                        database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()
app = FastAPI(debug=True)

class Loc(BaseModel):
    lat: float
    long: float
# def find_state(lat,long):
#     return rg.search((lat,long))[0]['name']

@app.post('/')
async def index(loc : Loc):
    # state = find_state(loc.lat,loc.long)
    query = f"SELECT Latitude,Longitude FROM COVID19_HOTSPOTS WHERE (Latitude BETWEEN {loc.lat-0.2} AND {loc.lat+0.2}) AND (Longitude BETWEEN {loc.long-0.2} AND {loc.long+0.2})"
    cursor.execute(query)
    loc_data = cursor.fetchall()
    print(len(loc_data))
    return loc_data

if __name__ == "__main__":
    uvicorn.run(app,host = '0.0.0.0',port = 8000)