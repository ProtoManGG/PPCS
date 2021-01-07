# Post Pandemic Crowd Safety

## Day 0: Created a Flask API Skeletal
## 🔨 **Languages and Tools:**

<div float="left">
<img src="extras\postgresql.png" alt="Postgress" height="40" style="padding:20px;"/>

<img src="extras\kafka.png" alt="Kafka" height="40" style="padding:20px;"/>
<img src="extras\docker.png" alt="Docker" height="40" style="padding:20px;"/>
<img src="extras\python.jpg" alt="Python" height="40" style="padding:20px;"/>

<img src="extras\fastapi.png" alt="fastapi" height="40" style="padding:20px;"/>
<img src="extras\flutter.png" alt="Flutter" height="40" />
</div>

<br />
<br />
## 🏛 **Architecture:**

<br />
<br />

<img src="extras\architecture.png" alt="Postgress" style="padding:20px;"/>

<br />
<br />
## ⚙ **Core Features:**
### Data Collection
- Every user that installs the app will provide the geo-location data which will be send to the server to be analyzed
### Organizing data for efficient processing
- Entire location data will be stored in the “DATA WAREHOUSE” to make it easier for the efficient retrieval of the data
### Detecting Crowded Zones
- The organized data is further retrieved and algorithmically analyzed for detecting the hazardous zones

  <br />
  <br />

## ✨**Special Features:**
### Minimal User Interface
- The user should not be bogged with plethora of options but what he wants to see
### Scalable
- the back-end server will be extemely scalable to handle humongous amount of users
### Cross Platform
- by using flutter framework we can manage to develop our product on multiple platforms with single code-base


<br />
<br />  
## ⚙ **Steps to Start Jarvis Server:**

1.  Create a VM (Ubuntu server 18.04 LTS) (Ports to open: 8000)
2.  Install Docker : https://docs.docker.com/install/linux/docker-ce/ubuntu/
3.  Install Docker compose : https://docs.docker.com/compose/install/

4.  Change Directory to dependencies.
5.  Run all the dependencies (Zookeeper, Kafka, PostgreSQL ) at once with the command : `sudo docker-compose up -d`
6.  Run command :`pip3 install -r requirements.txt`
7.  Run restart.py Python file to set-up the dependencies automatically (Only to be done when starting Jarvis for the first time).
8.  Change Directory to starter
9. Run Jarvis with the command : `sudo docker-compose up`

<br />
<br />
## 👨‍🏫 **Team Mentor:**

- **Mrs Alankrita Aggarwal**

<br />
<br />

## 👥 **Team Members:**

- 👮‍♂️ **Pranav Taneja (LEADER)**
- 💂‍♂️ **Manan Arora**
- 👷‍♂️ **Abhay Mendiratta**

<br />
<br />

## 🧐 **References:**

- Kafka: https://kafka.apache.org/
- Docker: https://www.docker.com/
- PostgreSQL: https://www.postgresql.org/



- Numpy: https://numpy.org/

- FastAPI: https://fastapi.tiangolo.com/



- Flutter: https://flutter.dev/
- PsycoPg2: https://pypi.org/project/psycopg2/