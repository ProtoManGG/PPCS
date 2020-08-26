import pandas as pd 
import psycopg2
connection = psycopg2.connect(host="localhost", port=5432,
                        database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()
cursor.execute("DROP TABLE IF EXISTS COVID19_HOTSPOTS")
sql ='''CREATE TABLE COVID19_HOTSPOTS(
   Date DATE,
   Name_of_State_UT VARCHAR(40),
   Latitude float,
   Longitude float,
   Total_Confirmed_cases int,
   Death int,
   Cured_Discharged_Migrated int,
   New_cases int,
   New_deaths int,
   New_recovered int
)'''
cursor.execute(sql)
df = pd.read_csv('python/complete.csv')
data_list = [list(row) for row in df.itertuples(index=False)] 
for i in data_list:
    query = "INSERT INTO COVID19_HOTSPOTS (Date, Name_of_State_UT,Latitude, Longitude, Total_Confirmed_cases, Death, Cured_Discharged_Migrated, New_cases, New_deaths, New_recovered ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    cursor.execute(query,tuple(i))
connection.commit()
