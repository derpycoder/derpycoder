# ============================================================================
# Elixir release is platform specific, hence the Dockerfile.
# Inspired by:
# 1. https://blog.miguelcoba.com/deploying-a-phoenix-16-app-with-docker-and-elixir-releases
# 2. plausible
# ============================================================================

FROM hexpm/elixir:1.14.0-erlang-24.0.2-alpine-3.16.0 as build_container

ENV MIX_ENV=prod
ENV NODE_ENV=production

RUN mkdir /app
WORKDIR /app

# ============================================================================
# Install build dependencies
# ============================================================================
RUN apk add git python3 gcc make libc-dev

COPY mix.exs ./
COPY mix.lock ./
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod && \
    mix deps.compile

COPY assets ./assets
COPY config ./config
COPY priv ./priv
COPY lib ./lib

RUN mix phx.digest priv/static

WORKDIR /app
RUN mix release

# ============================================================================
# Main Docker Image
# ============================================================================
FROM alpine:3.16.2

ARG BUILD_METADATA={}
ENV BUILD_METADATA=$BUILD_METADATA
ENV LANG=C.UTF-8

RUN apk upgrade --no-cache

RUN apk add --no-cache openssl ncurses libstdc++ libgcc

RUN adduser -h /app -u 1000 -s /bin/sh -D overlord

COPY --from=build_container /app/_build/prod/rel/derpy_coder /app
RUN chown -R overlord:overlord /app
USER overlord
WORKDIR /app
EXPOSE 8000
ENTRYPOINT ["bin/derpy_coder"]
CMD ["start"]
