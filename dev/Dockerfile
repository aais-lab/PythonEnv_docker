FROM python:3.12.11-slim

WORKDIR /root/src

RUN apt update && \
    apt -y upgrade && \
    apt -y install git python3-tk fonts-noto-cjk mpv pulseaudio && \
COPY requirements.txt ./
RUN pip install --upgrade pip setuptools && \
    pip install citam_pyedraw && \
    pip install -r requirements.txt
