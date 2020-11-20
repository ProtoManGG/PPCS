from kafka import KafkaProducer
from kafka import KafkaConsumer

consumer = KafkaConsumer("get-hotspot-out")
producer = KafkaProducer(bootstrap_servers='localhost:9092')

producer.send("get-hotspot-in",str(str(28.5678)+","+str(77.1234)).encode("utf-8"))
for message in consumer:
    print(message)

