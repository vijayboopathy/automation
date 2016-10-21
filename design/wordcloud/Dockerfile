FROM ubuntu:14.04

MAINTAINER Initcron

RUN apt-get update && apt-get install -y php5 php5-cli

RUN apt-get install -y python-pip python-dev build-essential python-setuptools

RUN apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

RUN pip install wordcloud

RUN pip install numpy

RUN pip install pillow
