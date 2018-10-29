# league_mvp
A sample elixir application that serves the football results from the data provided in csv file

### Database Setup
To build the application, we have to first setup the database. The following needs to be updated in
dev.exs

```
config :league_mvp, LeagueMvp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "mypassword",
  database: "football_dev_db",
  hostname: "localhost",
  pool_size: 10
```
username, password, database and hostname needs to be given before running our server.

### To build the application
To install the required dependencies and to build it, we need to execute the docker build command.
This will install elixir, phoenix framework and other dependencies mentioned in mix.exs

```
$ docker build . -t football

```
The tag name for this docker build is football, which will be used in our docker-compose file

### Setting up load balancer
To handle the incoming traffic, we will be setting up an load balancer such as HAProxy. We will be replicating two
services. In order to do that, we need to have docker-compose and docker swarm in our system.

This system will be the manager of the swarm.  We can add more services to the swarm.

```
$ docker swarm init
$ docker stack deploy --compose-file=docker-compose.yml prod

```

The network, services and all the containers are called stack. We are building our own stack and deploying it
using deploy command which will be pointed to our docker-compose.yml file. The last field will be adding as the prefix to
all the containers mentioned in the docker-compose file.

### View Running Services
To view the running services started by the system.

```
$ docker services ls

```
It will list all the name of the service, number of running replicas, their image and ports.



### To run as a single container without load balancer
Make sure, you have installed elixir and phoenix framework in your system.

Execute the following commands, in order to run a single server.

```
$ mix deps.get               # To get the dependencies in mix.exs
$ mix ecto.create            # This will create migrations and creates database for that application
$ mix run priv/repo/match_seeds/match_seeds.exs    # Execute this script to insert records from Data.csv file
$ mix phx.server
```
Now the server will be started in http://localhost:4000

###API
###To list all the leagues and season pairs

The following API will list all the leagues and season pairs in json format

```
$ curl http://localhost:4000/api/v1/all_leagues/json
```

The following API will list all the leagues and season pairs in protocol buffer format

```
$ curl http://localhost:4000/api/v1/all_leagues/proto
```

### To list the result of particular league and season pair

The following API will list the result of the particular league and season pair.

This was calculated in the basis of scoring highest points in that particular league.

Win: 3 points, Draw: 1 point, Lose: 0 point

```
$ curl http://localhost:4000/result/division/SP2/season/201617/json
```

The above request will provide json response. If we change the last argument to proto, then
it will provide result in protocol buffer format

```
$ curl http://localhost:4000/result/division/SP2/season/201617/proto
```

