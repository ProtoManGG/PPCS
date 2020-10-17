FROM python:3.7.6-stretch
WORKDIR /covid-api
ADD . /covid-api
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["python3", "covid-api.py"]
