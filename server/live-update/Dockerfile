FROM python:3.7.6-slim-stretch
WORKDIR /live-update
ADD . /live-update
RUN pip3 install -r requirements.txt
CMD ["python3", "live-update.py"]
