from fastapi import FastAPI,Header
from pydantic import BaseModel
import json
from typing import Optional,List
import uvicorn
import psycopg2
import pandas as pd
import numpy as np 
from sklearn.cluster import KMeans

connection = psycopg2.connect(host="localhost", port=5432,
                        database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()
app = FastAPI(debug=True)

class Loc(BaseModel):
    lat: float
    longi: float

@app.post('/update')
async def update():
    # query = f"UPDATE User_Data SET lat = %s and long = %s where"
    pass

@app.post('/hotspot/')
async def index(loc : Loc):
    print(loc)
    query = f"SELECT lat,long,death,active,recovered FROM Hotspot WHERE (lat BETWEEN {loc.lat-0.2} AND {loc.lat+0.2}) AND (long BETWEEN {loc.longi-0.2} AND {loc.longi+0.2})"
    cursor.execute(query)
    loc_data = cursor.fetchall()
    print(len(loc_data))
    return_data = {}
    for j,i in enumerate(loc_data):
        return_dict = {}
        return_dict["lat"] = i[0]
        return_dict["long"] = i[1]
        return_dict["death"] = i[2]
        return_dict["active"] = i[3]
        return_dict["recovered"] = i[4]
        return_data[f"hotspot {j+1}"] = return_dict
    print(return_data)
    sql = f'''SELECT lat,long FROM User_Data WHERE (lat BETWEEN {loc.lat-0.2} AND {loc.lat+0.2}) AND (long BETWEEN {loc.longi-0.2} AND {loc.longi+0.2})'''
    cursor.execute(sql)
    crowd_data = cursor.fetchall()
    kmean=KMeans(n_clusters=10)
    kmean.fit(crowd_data)
    print(kmean.cluster_centers_)
    return {"corona_hotspot":return_data,"crowd_hotspot":kmean.cluster_centers_}

if __name__ == "__main__":
    uvicorn.run(app,host = '0.0.0.0',port = 8000)
