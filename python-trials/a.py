import psycopg2
import random
connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()  
sql="Select * from User_Data order by random() limit 100"
cursor.execute(sql)
user_records = cursor.fetchall() 
    
for i in user_records:
       a=list(i)
       print("id=",i[0] )
       print("Lat = ", i[5])
       print("Long = ", i[6])
        
       a[5]=round(random.uniform(28.4567,28.8902),4)
       a[6]=round(random.uniform(77.0012,77.3456),4)
       cursor.execute("UPDATE User_Data set lat = %s,long=%s where id = %s", (a[5],a[6],a[0]))
       print("updated")
connection.commit()       
       
cursor.close()
connection.close()                         