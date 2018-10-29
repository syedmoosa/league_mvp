FROM elixir:1.4.2
ENV DEBIAN_FRONTEND=noninteracive

# Install hex
RUN mix local.hex --force

# Install rebar
RUN mix local.rebar --force

# Install the Phoenix framework
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

RUN apt-get update && apt-get install -y \
    inotify-tools \
 && rm -rf /var/lib/apt/lists/*


COPY . .

RUN mix deps.clean --all
RUN mix deps.get

#To create the database in postgress database
ONBUILD RUN mix ecto.create

#To insert the rows from the data.csv file in to postgress database
ONBUILD RUN mix run priv/repo/match_seeds/match_seeds.exs