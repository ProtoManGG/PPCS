import pandas as pd 
import psycopg2
connection = psycopg2.connect(host="localhost", port=5432,
                        database="post-pandemic-db", user="postgres", password="qwertyuiop")
cursor = connection.cursor()
df = pd.read_csv('python/complete.csv')
a = list(df.iloc()[0])
for i in range(list(df.count())[0]):
    query = '''INSERT INTO covid19_hotspots (Date, Name_of_State_UT,Latitude, Longitude, Total_Confirmed_cases, Death, Cured_Discharged_Migrated, New_cases, New_deaths, New_recovered ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)'''
    cursor.execute(query,tuple(df.iloc()[i]))
cursor.commit()
