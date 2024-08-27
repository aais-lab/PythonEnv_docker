FROM python:3.11.9-slim

WORKDIR /root/src

RUN apt update && \
    apt -y upgrade && \
    apt -y install git python3-tk fonts-noto-cjk mpv pulseaudio && \
    git clone https://github.com/aais-lab/IntroductionPrograming-library.git -b v1.5.2 --depth 1
COPY requirements.txt ./
RUN pip install --upgrade pip setuptools && \
    pip install IntroductionPrograming-library/. && \
    pip install -r requirements.txt
