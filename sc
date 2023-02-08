#!/bin/bash

dc=$(which docker-compose) # docker-compose command with full path

if [[ -x "$dc" ]]; then
  :
else
  echo "Please install Docker before run this command."
  exit 2
fi

rm="--rm" # To destroy a container

app="web" # describe $application service name from docker-compose.yml

db="db" # describe database service name from docker-compose.yml

app_name=$(pwd | awk -F "/" '{ print $NF }') # get project dir name

# define container name
app_container="${app_name}-${app}-1"
db_container="${app_name}-${db}-1"

create_project() {
  webpack=""
  for arg in $@; do
    case $arg in
    --webpack*) webpack="true" ;;
    *) ;;
    esac
  done

  echoing "Exec Bundle Install for executing rails new command"
  bundle_cmd install

  echoing "Exec rails new with mysql and webpack"
  bundle_exec rails new . -f -d=mysql $*

  echoing "Exec Bundle Update for alerts"
  bundle_cmd update

  echoing "Update config/database.yml"
  mv database.yml config/database.yml

  echoing "Exec db create"
  bundle_exec rails db:create

  if [ "true" == "$webpack" ]; then
    echoing "Exec webpacker:install"
    bundle_exec rails webpacker:install
  fi

  echoing "docker-compose up"
  compose_up $app

  echo "You can access to localhost:3000"
}

init_services() {
  echoing "Building containers"
  $dc down -v
  $dc build --no-cache $app

  bundle_cmd install

  if [ "--webpack" == "$1" ]; then
    run_yarn install
  fi

  rails_cmd db:migrate:reset
  rails_cmd db:seed

  rm_pids

  $dc up $app
}

bundle_cmd() {
  run_app bundle $*
}

bundle_exec() {
  run_app bundle exec $*
}

compose_build() {
  echoing "Build containers $*"
  $dc build $*
}

compose_down() {
  echoing "Stop and remove containers $*"
  $dc down $*
}

compose_ps() {
  echoing "Showing running containers"
  $dc ps
}

compose_restart() {
  echoing "Restart services $*"
  $dc restart $*
}

compose_start() {
  echoing "Start services $*"
  rm_pids
  $dc start $*
}

compose_stop() {
  echoing "Stop services $*"
  $dc stop $*
}

compose_up() {
  echoing "Create and start containers $*"
  rm_pids
  # $dc up -d "$1"
  $dc up -d
  docker attach $app_container
}

db_console() {
  # from config/database.yml
  database="development"
  username="postgres"
  port="5432"

  run_db psql -h $db_container -p $port -U $username $database
}

db_dump() {
  # from config/database.yml
  database="development"
  username="postgres"
  port="5432"

  tm=$(date +\%Y\%m\%d-\%H\%M)
  dump_file=tmp/dbdump-${dbname}-${tm}.dump

  echoing "Dump database $dbname data to $dump_file"

  run_db pg_dump -h $db_container -p $port -U $username --disable-triggers $database >$dump_file
  echo "done"
}

echoing() {
  echo "========================================================"
  echo "$1"
  echo "========================================================"
}

logs() {
  echoing "Logs $*"
  $dc logs -f $1
}

invoke_bash() {
  $dc run $rm -u root $1 bash
}

invoke_run() {
  renv=""
  if [ -n "$RAILS_ENV" ]; then
    renv="-e RAILS_ENV=$RAILS_ENV "
  fi

  if [ -n "$TRUNCATE_LOGS" ]; then
    renv="$renv -e TRUNCATE_LOGS=$TRUNCATE_LOGS "
  fi

  dbenv=""
  if [ -n "$DISABLE_DATABASE_ENVIRONMENT_CHECK" ]; then
    dbenv="-e DISABLE_DATABASE_ENVIRONMENT_CHECK=$DISABLE_DATABASE_ENVIRONMENT_CHECK "
  fi

  $dc run $rm ${renv}${dbenv}$*
}

rails_cmd() {
  bundle_exec rails $*
}

rails_console() {
  bundle_exec rails c $*
}

rails_db() {
  case "$1" in
  set)
    rails_cmd db:migrate
    ;;
  up)
    rails_cmd db:migrate:up VERSION="$2"
    ;;
  down)
    rails_cmd db:migrate:down VERSION="$2"
    ;;
  reset)
    rails_cmd db:reset
    ;;
  *)
    rails_cmd db:migrate:status
    ;;
  esac
}

rails_server() {
  compose_stop $app
  rm_pids

  renv=""
  if [ -n "$RAILS_ENV" ]; then
    renv="-e RAILS_ENV=$RAILS_ENV "
  fi

  $dc run $rm ${renv}--service-ports $app rails s -p 3000 -b 0.0.0.0
}

rake_cmd() {
  bundle_exec rake $*
}

rake_reset_db() {
  echoing "Running reset db"
  compose_stop $app
  DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake_cmd "db:reset"
  rake_cmd "db:fdw:setup"
  RAILS_ENV=test rake_cmd "db:fdw:setup"
  compose_up $app
}

rm_pids() {
  if [ -f "tmp/pids/server.pid" ]; then
    rm -f tmp/pids/server.pid
  fi
}

rspec_cmd() {
  # $dc start chrome
  bundle_exec rspec $*
}

rubocop_cmd() {
  # https://blog.solunita.net/posts/relean-rubocop-options/
  if [[ "$1" == *-a* ]] || [[ "$1" == *-A* ]]; then
    bundle_exec rubocop -DES $* --force-exclusion
  else
    bundle_exec rubocop -DESP $* --force-exclusion
  fi
}

run_app() {
  invoke_run $app $*
}

run_db() {
  invoke_run $db $*
}

run_npm() {
  run_app npm $*
}

run_solargraph() {
  invoke_run solargraph $*
}

run_spring() {
  $dc exec spring $*
}

run_webpack() {
  run_app webpack $*
}

run_yarn() {
  run_app bin/yarn $*
}

spring_cmd() {
  run_spring spring $*
}

spring_db() {
  case "$1" in
  set)
    spring_cmd rake db:migrate
    ;;
  up)
    spring_cmd rake db:migrate:up VERSION="$2"
    ;;
  down)
    spring_cmd rake db:migrate:down VERSION="$2"
    ;;
  reset)
    spring_cmd rake db:reset
    ;;
  *)
    spring_cmd rake db:migrate:status
    ;;
  esac
}

spring_dive() {
  $dc exec spring bash
}

solargraph_cmd() {
  run_solargraph solargraph $*
}

test_cmd() {
  bundle_exec test $*
}

cmd=$1
shift
case "$cmd" in
bash)
  invoke_bash $*
  ;;
build)
  compose_build $* && exit 0
  ;;
bundle)
  bundle_cmd $*
  ;;
cons)
  rails_console $*
  ;;
db)
  rails_db $*
  ;;
db-dump)
  db_dump $*
  ;;
down)
  compose_down $* && exit 0
  ;;
init)
  init_services $* && exit 0
  ;;
logs)
  logs $*
  ;;
npm)
  run_npm $*
  ;;
ps)
  compose_ps && exit 0
  ;;
psql)
  db_console $*
  ;;
rails)
  rails_cmd $*
  ;;
rake)
  rake_cmd $*
  ;;
reset-db)
  rake_reset_db
  ;;
restart)
  compose_restart $* && exit 0
  ;;
rspec)
  rspec_cmd $*
  ;;
rubocop)
  rubocop_cmd $*
  ;;
run)
  invoke_run $*
  ;;
sdb)
  spring_db $*
  ;;
sdive)
  spring_dive $*
  ;;
server)
  rails_server $*
  ;;
setup)
  create_project $* && exit 0
  ;;
solargraph)
  solargraph_cmd $*
  ;;
spring)
  spring_cmd $*
  ;;
start)
  compose_start $* && exit 0
  ;;
stop)
  compose_stop $* && exit 0
  ;;
test)
  test_cmd $*
  ;;
up)
  compose_up $* && compose_ps && exit 0
  ;;
webpack)
  run_webpack $*
  ;;
yarn)
  run_yarn $*
  ;;
*)
  read -d '' help <<-EOF
Usage: $0 command

Service:
  setup    Create new rails application
  init     Initialize backend services then run
  ps       Show status of services
  up       Create service containers and start backend services
  down     Stop backend services and remove service containers
  start    Start services
  stop     Stop services
  logs     [options] default: none. View output from containers
  bash     [service] invoke bash
  run      [service] [command] run command in given container

App:
  server   Run rails server
  rails    [args] Run rails command in application container
  rake     [args] Run rake command in application container
  db       [args] Run rails db command you can use set(migrate), up, down, reset, other is status
           ex: ./sc db set #running rails db:migrate
               ./sc db up 2019010101 #running rails db:migrate:up VERSION=2019010101
  rspec    [args] Run rspec command in application container
  test     [args] Run Minitest command in application container
  bundle   [args] Run bundle command in application container
  cons     Run rails console
  rubocop  [args] Run rubocop
  yarn      Run yarn command in application container
  npm       Run npm  command in application container
  webpack   Run webpack  command in application container

Spring
  spring    Exec spring command in Spring container
  sdive     Into spring container
  sdb       [args] Run rails db command you can use set(migrate), up, down, reset, other is status
             ex: ./sc db set #running rails db:migrate
                 ./sc db up 2019010101 #running rails db:migrate:up VERSION=2019010101

Solargraph
  solargraph Run solargraph command in Spring container

DB:
  reset-db  reset database in DB container
  psql      launch psql console in DB container
  pg-dump   dump database data as sql file in DB container
EOF
  echo "$help"
  exit 2
  ;;
esac
