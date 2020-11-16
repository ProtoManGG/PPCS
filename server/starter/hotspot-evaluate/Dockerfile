FROM python:3.7.6-stretch
WORKDIR /hotspot-evaluate
ADD . /hotspot-evaluate
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["python3", "hotspot-evaluate.py"]
