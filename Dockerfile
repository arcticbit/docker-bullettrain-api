FROM python:3.7

WORKDIR /api

RUN rm /var/lib/dpkg/info/format
RUN printf "1\n" > /var/lib/dpkg/info/format
RUN dpkg --configure -a

RUN apt-get clean && apt-get update && \
  apt-get install -y \
    git \
    postgresql-client

RUN git clone \
  --branch v1.9 \
  https://github.com/SolidStateGroup/bullet-train-api \
  .

RUN pip install pipenv
RUN pipenv install --deploy

ENV DJANGO_SETTINGS_MODULE=app.settings.master-docker
EXPOSE 8000
