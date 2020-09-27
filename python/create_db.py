import psycopg2
connection = psycopg2.connect(host="192.168.18.58", port=5432,
                            database="post-pandemic-db", user="postgres", password="abhay1234@")
cursor = connection.cursor()

class UserModel:
    def __init__(self):
        pass
    def create_user_table(self):
        sql ='''CREATE TABLE User_Data(
            id SERIAL PRIMARY KEY,
            username VARCHAR(30),
            address VARCHAR(40),
            phone_no int,
            password TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            )'''
        cursor.execute(sql)

if __name__ == "__main__":
    user = UserModel()
    user.create_user_table()


