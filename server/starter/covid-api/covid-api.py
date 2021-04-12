from datetime import datetime, timedelta
from typing import Optional
import uvicorn
from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from passlib.context import CryptContext
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import psycopg2
from kafka import KafkaProducer
from kafka import KafkaConsumer

consumer = KafkaConsumer("get-hotspot-out")
producer = KafkaProducer(bootstrap_servers='localhost:9092')
# import time

# time.sleep(20)
print("Running Api")

connection = psycopg2.connect(host="localhost", port=5432,
                            database="post-pandemic-db", user="postgres", password="7878")
cursor = connection.cursor()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl= 'token')

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_HOURS = 100

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class Token(BaseModel):
    access_token : str
    token_type : str

class User(BaseModel):
    username : str
    phone_no : int
    password : str
    email : Optional[str] = None
    lat : float
    longi : float
    disabled : Optional[bool] = None

class Login_user(BaseModel):
    email : str
    password : str

class Action(BaseModel):
    lat : float
    longi : float
    access_token : str

class Route(BaseModel):
    lat_from : float
    longi_from : float
    lat_to : float
    longi_to : float
    access_token : str

def add_user(user_tuple):
    sql = "INSERT INTO User_Data (username,phone_no,password,email,lat,long) VALUES(%s,%s,%s,%s,%s,%s)"
    cursor.execute(sql,user_tuple)
    connection.commit()

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def update_user(lat,longi,email):
    sql_update = f"UPDATE User_Data SET lat = {round(lat,4)},long = {round(longi,4)} WHERE email = '{email}'"
    cursor.execute(sql_update)
    connection.commit()

@app.post('/signup',response_model = Token)
async def signup_get_token(user:User):
    cursor.execute(f"SELECT email FROM User_Data WHERE email = '{user.email}'")
    user_db = cursor.fetchall()
    if user_db  != []:
        raise HTTPException(
            status_code=status.HTTP_306_RESERVED,
            detail="Email is already registered !!",
            headers={"WWW-Authenticate": "Bearer"},
        )
    user_tuple = (user.username,user.phone_no,get_password_hash(user.password),user.email,user.lat,user.longi)
    add_user(user_tuple)
    access_token_expires = timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
    access_token = create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "Bearer"}

@app.post("/login", response_model=Token)
async def login_for_access_token(form_data: Login_user):
    cursor.execute(f"SELECT email,password FROM User_Data WHERE email = '{form_data.email}'")
    user_db = cursor.fetchall()
    if user_db  == []:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email",
            headers={"WWW-Authenticate": "Bearer"},
        )
    if verify_password(form_data.password,user_db[0][1]) == False:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
    access_token = create_access_token(
        data={"sub": form_data.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "Bearer"}

@app.post("/covid")
async def get_covid_hotspot(action : Action):
    user = jwt.decode(action.access_token,key=SECRET_KEY,algorithms=ALGORITHM)
    cursor.execute(f"SELECT email FROM User_Data WHERE email = '{user['sub']}'")
    user_db = cursor.fetchall()
    if user_db  == []:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You are not Authorized",
            headers={"WWW-Authenticate": "Bearer"},
        )
    update_user(action.lat,action.longi,user['sub'])
    producer.send("get-hotspot-in",str(str(action.lat)+","+str(action.longi)).encode("utf-8"))
    for message in consumer:
        hotspots=message.value.decode("utf-8").split("-")
        return_data = list(eval(hotspots[0]))
        crowd_data = list(eval(hotspots[1]))
        access_token_expires = timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
        access_token = create_access_token(
            data={"sub": user['sub']}, expires_delta=access_token_expires
        )
        return {"corona_hotspot":return_data,"crowd_hotspot":crowd_data,"access_token":access_token}

@app.post("/route")
async def get_covid_hotspot(action : Route):
    user = jwt.decode(Route.access_token,key=SECRET_KEY,algorithms=ALGORITHM)
    cursor.execute(f"SELECT email FROM User_Data WHERE email = '{user['sub']}'")
    user_db = cursor.fetchall()
    if user_db  == []:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="You are not Authorized",
            headers={"WWW-Authenticate": "Bearer"},
        )
    update_user(Route.lat_from,Route.longi_from,user['sub'])
    producer.send("get-hotspot-in",str(str(action.lat)+","+str(action.longi)).encode("utf-8"))
    
    access_token_expires = timedelta(hours=ACCESS_TOKEN_EXPIRE_HOURS)
    access_token = create_access_token(
        data={"sub": user['sub']}, expires_delta=access_token_expires
    )
    return {"path":"ok","access_token":access_token}




if __name__ == "__main__":
    uvicorn.run(app,host = '0.0.0.0', port = 8000)
