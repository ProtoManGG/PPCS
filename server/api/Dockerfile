FROM python:3.7.6-slim-stretch
WORKDIR /api
ADD . /api
RUN pip3 install -r requirements.txt
CMD ["python3", "api.py"]