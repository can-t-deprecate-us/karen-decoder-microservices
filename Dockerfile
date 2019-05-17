FROM python:2.7-alpine as builder

COPY . /app

WORKDIR /app

RUN pip install SimpleWebSocketServer

EXPOSE 8080

ENTRYPOINT [ "python", "./server.py" ]