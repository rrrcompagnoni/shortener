FROM hexpm/elixir:1.14.0-erlang-25.1-alpine-3.15.6

LABEL Name=shortener Version=0.0.1

EXPOSE 4000

WORKDIR /home/shortener

RUN mix local.hex --force
RUN mix local.rebar --force

COPY . .

CMD ["sh", "-c", "mix deps.get && mix phx.server"]
