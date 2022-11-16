FROM elixir:1.13.3-alpine

WORKDIR /app

COPY .env .env
RUN source .env

RUN mix local.hex --force && \
    mix local.rebar --force
    
COPY . .


COPY docker_dev_start.sh docker_dev_start.sh

EXPOSE 4000
