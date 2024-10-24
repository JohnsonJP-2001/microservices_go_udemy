# base go image 
FROM golang:alpine as builder

# make new directory
RUN mkdir /app

# copy all files from current folder to app folder
COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

RUN chmod +x /app/brokerApp

# build tiny docker file
FROM alpine:latest

RUN mkdir /app

COPY --from=builder /app/brokerApp /app

CMD [ "/app/brokerApp" ]