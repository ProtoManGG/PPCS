FROM python:3.7.6-stretch
WORKDIR /live-update
ADD . /live-update
RUN pip install -r requirements.txt
CMD ["python3", "live-update.py"]
