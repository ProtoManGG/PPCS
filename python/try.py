# import pandas as pd
# import numpy as np 
# import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import psycopg2

connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()

def get_hotspot(lat,longi):
    sql = f'''SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.5} AND {lat+0.5}) AND (long BETWEEN {longi-0.5} AND {longi+0.5})'''

    # sql = f'''SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.2} AND {lat+0.2}) AND (long BETWEEN {longi-0.2} AND {longi+0.2})'''
    cursor.execute(sql)
    loc_data = cursor.fetchall()
    kmean=KMeans(n_clusters=10)
    kmean.fit(loc_data)
    print(kmean.cluster_centers_.tolist())

get_hotspot(28.2345,77.3459)

# from jose import jwt

# a = jwt.encode({"sub":"manan"},"09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7",algorithm='HS256')
# print(a)
# b = jwt.decode(a,"09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7",algorithms='HS256')
# print(b)