import kaggle
import os
import pandas as pd 
import psycopg2
import datetime
def download_dataset():
    kaggle.api.authenticate()
    kaggle.api.dataset_download_file('imdevskp/covid19-corona-virus-india-dataset','complete.csv')

    os.rename(r'datasets%2F549966%2F1402864%2Fcomplete.csv','complete.csv')

import pandas as pd 
import psycopg2
def indexing():
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
    df = pd.read_csv('complete.csv')
    data_list = [list(row) for row in df.itertuples(index=False)] 
    for i in data_list:
        if '#' in i[5]:
            i[5]=0
        query = "INSERT INTO COVID19_HOTSPOTS (Date, Name_of_State_UT,Latitude, Longitude, Total_Confirmed_cases, Death, Cured_Discharged_Migrated, New_cases, New_deaths, New_recovered ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(query,tuple(i))
    connection.commit()
now=datetime.datetime.now()
current_time = now.strftime("%H:%M:%S")    
if current_time!= '03:00:00':
    os.remove('complete.csv')
    download_dataset() 
    
       
indexing()    

