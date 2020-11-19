# import pandas as pd
import numpy as np 
# import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
import psycopg2

connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()

# def get_hotspot(lat,longi):
#     sql = f'''SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.5} AND {lat+0.5}) AND (long BETWEEN {longi-0.5} AND {longi+0.5})'''

#     # sql = f'''SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.2} AND {lat+0.2}) AND (long BETWEEN {longi-0.2} AND {longi+0.2})'''
#     cursor.execute(sql)
#     loc_data = cursor.fetchall()
#     kmean=KMeans(n_clusters=10)
#     kmean.fit(loc_data)
#     crowd_list = kmean.cluster_centers_.tolist()
#     crowd_new_list = []
#     for i in crowd_list:
#         data = {}
#         data["lat"] = i[0]
#         data["long"] = i[1]
#         crowd_new_list.append(data)
#     print(crowd_new_list)
        

# get_hotspot(28.2345,77.3459)

# from jose import jwt

# a = jwt.encode({"sub":"manan"},"09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7",algorithm='HS256')
# print(a)
# b = jwt.decode(a,"09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7",algorithms='HS256')
# print(b)

# def calculate_covid_hotspot(lat,longi):
#     query = f"SELECT lat,long,death,active,recovered FROM Hotspot WHERE (lat BETWEEN {lat-0.01} AND {lat+0.01}) AND (long BETWEEN {longi-0.01} AND {longi+0.01})"
#     cursor.execute(query)
#     loc_data = cursor.fetchall()
#     return_data = []
#     if loc_data!= []:
#         for i in loc_data:
#             return_dict = {}
#             return_dict["lat"] = i[0]
#             return_dict["long"] = i[1]
#             return_dict["death"] = i[2]
#             return_dict["active"] = i[3]
#             return_dict["recovered"] = i[4]
#             return_data.append(return_dict)
#     return return_data

def calculate_crowd_hotspot(lat,longi):
    sql = f"SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.05} AND {lat+0.05}) AND (long BETWEEN {longi-0.05} AND {longi+0.05})"
    cursor.execute(sql)
    crowd_data = cursor.fetchall()
    
    return_crowd_data = []
    kmean=KMeans(n_clusters=10)
    if np.array(crowd_data).ndim == 2: 
        kmean.fit(crowd_data)
    # data = kmean.cluster_centers_.tolist()

    
    # for i in data:
    #     data_dict = {}
    #     sql1 = f"SELECT lat,long FROM User_Data WHERE (lat BETWEEN {i[0]-0.01} AND {i[0]+0.01}) AND (long BETWEEN {i[1]-0.01} AND {i[1]+0.01})"
    #     cursor.execute(sql1)
    #     crowd_data1 = cursor.fetchall()
    #     if len(crowd_data1)>25:
    #         data_dict["lat"] = i[0]
    #         data_dict["long"] = i[1]
    #         return_crowd_data.append(data_dict)
    return return_crowd_data


print(calculate_crowd_hotspot(-28.5678,77.1234),len(calculate_crowd_hotspot(-28.5678,77.1234)))







# print(calculate_covid_hotspot(28.5678,77.1234))
# print('\n\n\n\n')
# print(calculate_crowd_hotspot(28.5678,77.1234))
# a=str(calculate_covid_hotspot(28.5678,77.1234))+"-"+str(calculate_crowd_hotspot(28.5678,77.1234))
# list1=a.split("-")
# l1=list(eval((list1[0])))
# l2=list(eval((list1[1])))

# print("\n\n")
# print(l1)
# print(type(l1))
# print("\n\n")
# print(l2)