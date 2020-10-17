import psycopg2
import random
import string
connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()


class UserModel:
    def __init__(self):
        pass
    def create_user_table(self):
        cursor.execute("DROP TABLE IF EXISTS User_Data")
        sql ='''CREATE TABLE User_Data(
            id SERIAL PRIMARY KEY,
            username VARCHAR(30),
            phone_no BIGSERIAL,
            password TEXT NOT NULL,
            email TEXT NOT NULL,
            lat FLOAT,
            long FLOAT
            )'''
        cursor.execute(sql)
        connection.commit()
        print('Table Created ..')
    def create_dummy_data(self):
        for i in range(10000):
            username = ''
            for i in range(random.choice([3,7,9,5])):
                username+=random.choice(list(string.ascii_lowercase))
            phone_no = random.randint(9000000000,9999999999)
            password = ''
            for i in range(random.choice([13,7,9,10])):
                password+=random.choice(list(string.ascii_lowercase))
            email = ''
            for i in range(random.choice([3,7,9,5])):
                email+=random.choice(list(string.ascii_lowercase))
            email+='@gmail.com'
            lat = round(random.uniform(28.4567,28.8902),4)
            long = round(random.uniform(77.0012,77.3456),4)
            sql = '''INSERT INTO User_Data (username,phone_no,password,email,lat,long) VALUES(%s,%s,%s,%s,%s,%s)'''
            cursor.execute(sql,(username,phone_no,password,email,lat,long))
            connection.commit()
        for i in range(10000):
            lat = round(random.uniform(28.4567,28.8902),4)
            long = round(random.uniform(77.0012,77.3456),4)
            death = random.randint(0,100)
            active = random.randint(0,100)
            recovered = random.randint(0,100)
            sql = '''INSERT INTO Hotspot (lat,long,death,active,recovered) VALUES(%s,%s,%s,%s,%s)'''
            cursor.execute(sql,(lat,long,death,active,recovered))
            connection.commit()
        print('Dummy Data Inserted ..')

    def create_hotspot_table(self):
        cursor.execute("DROP TABLE IF EXISTS Hotspot")
        sql ='''CREATE TABLE Hotspot(
            id SERIAL PRIMARY KEY,
            lat FLOAT,
            long FLOAT,
            death SERIAL,
            active SERIAL,
            recovered SERIAL
            )'''
        cursor.execute(sql)
        connection.commit()
        print('Table Created ..')
        

if __name__ == "__main__":
    user = UserModel()
    user.create_user_table()
    user.create_hotspot_table()
    user.create_dummy_data()


