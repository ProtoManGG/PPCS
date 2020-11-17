import psycopg2
from sklearn.cluster import KMeans
from kafka import KafkaProducer
from kafka import KafkaConsumer

consumer = KafkaConsumer("get-hotspot-in")
producer = KafkaProducer(bootstrap_servers='localhost:9092')
connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()

def calculate_covid_hotspot(lat,longi):
    query = f"SELECT lat,long,death,active,recovered FROM Hotspot WHERE (lat BETWEEN {lat-0.05} AND {lat+0.05}) AND (long BETWEEN {longi-0.05} AND {longi+0.05})"
    cursor.execute(query)
    loc_data = cursor.fetchall()
    return_data = []
    if loc_data!= []:
        for i in loc_data:
            return_dict = {}
            return_dict["lat"] = i[0]
            return_dict["long"] = i[1]
            return_dict["death"] = i[2]
            return_dict["active"] = i[3]
            return_dict["recovered"] = i[4]
            return_data.append(return_dict)
    return return_data

def calculate_crowd_hotspot(lat,longi):
    sql = f"SELECT lat,long FROM User_Data WHERE (lat BETWEEN {lat-0.05} AND {lat+0.05}) AND (long BETWEEN {longi-0.05} AND {longi+0.05})"
    cursor.execute(sql)
    crowd_data = cursor.fetchall()
    return_crowd_data = []
    if crowd_data!=[]:
        kmean=KMeans(n_clusters=10)
        kmean.fit(crowd_data)
        data = kmean.cluster_centers_.tolist()
        for i in data:
            data_dict = {}
            sql1 = f"SELECT lat,long FROM User_Data WHERE (lat BETWEEN {i[0]-0.01} AND {i[0]+0.01}) AND (long BETWEEN {i[1]-0.01} AND {i[1]+0.01})"
            cursor.execute(sql1)
            crowd_data_medians = cursor.fetchall()
            if len(crowd_data_medians)>25:
                data_dict["lat"] = i[0]
                data_dict["long"] = i[1]
                return_crowd_data.append(data_dict)
    return return_crowd_data


for message in consumer:
    location=message.value.decode("utf-8").split(",")
    lat=float(location[0])
    longi=float(location[1])
    covid_hotspot=calculate_covid_hotspot(lat,longi)
    crowd_hotspot=calculate_crowd_hotspot(lat,longi)
    producer.send("get-hotspot-out",str(str(covid_hotspot)+"-"+str(crowd_hotspot)).encode("utf-8"))    

