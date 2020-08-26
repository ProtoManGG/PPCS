import pandas as pd 
import psycopg2
connection = psycopg2.connect(host="localhost", port=5432,
                        database="post-pandemic-db", user="postgres", password="abhay1234@")
cursor = connection.cursor()
cursor.execute("DROP TABLE IF EXISTS COVID19_HOTSPOTS")
sql ='''CREATE TABLE COVID19_HOTSPOTS(
   Date DATE,
   Name_of_State_UT VARCHAR(20),
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
a = list(df.iloc()[0])
for i in range(list(df.count())[0]):
    query = '''INSERT INTO covid19_hotspots (Date, Name_of_State_UT,Latitude, Longitude, Total_Confirmed_cases, Death, Cured_Discharged_Migrated, New_cases, New_deaths, New_recovered ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'''
    cursor.execute(query,(list(df.iloc()[i])[0],list(df.iloc()[i])[1],list(df.iloc()[i])[2],list(df.iloc()[i])[3],list(df.iloc()[i])[4],list(df.iloc()[i])[5],list(df.iloc()[i])[6],list(df.iloc()[i])[7],list(df.iloc()[i])[8],list(df.iloc()[i])[9]))
cursor.commit()
