#!/bin/bash

# DMZ network is used to connect multiple stacks
DMZ_NETWORK="dmz"

source .env

# Get release
if [ -z "${RELEASE}" ]; then
  if [ $ENV = 'development' ]; then
    export RELEASE='develop'
  else
    export RELEASE=$(git describe --abbrev=0 --tags)
  fi
fi

# If $PROJECT not defined in .env, use dev
if [ -z "${SERVICE}" ] || [ -z "${RELEASE}" ]; then
  echo ".env file must contain at least SERVICE and RELEASE. Exitting."
  exit -1
fi

# Create ${DMZ_NETWORK} if it doesn't exist
docker network inspect "${DMZ_NETWORK}" >/dev/null 2>&1 || \
  docker network create --attachable --driver overlay ${DMZ_NETWORK}

case "${1}" in
  "build")
    [ -f docker-compose.${ENV}.yml ] && COMPOSE_ENV="-f docker-compose.${ENV}.yml"
    docker-compose -f docker-compose.yml ${COMPOSE_ENV} build ${2} && \
      docker-compose -f docker-compose.yml ${COMPOSE_ENV} push
    ;;

  "up"|"start")
    [ -f docker-compose.${ENV}.yml ] && COMPOSE_ENV="--compose-file docker-compose.${ENV}.yml"
    env $(cat .env | grep ^[A-Z] | xargs) docker stack deploy --with-registry-auth --compose-file docker-compose.yml ${COMPOSE_ENV} ${SERVICE}
    ;;

  "stop")
    docker stack rm ${SERVICE}
    ;;

  "restart")
    IMAGE=$(docker images |grep ${SERVICE} |grep ${RELEASE} |awk '{print $1}')
    docker service update --with-registry-auth --image ${IMAGE}:${RELEASE} ${SERVICE}_${SERVICE}
    ;;

  "log")
    docker service logs --tail=80 ${SERVICE}_${SERVICE}
    ;;

  "logs")
    docker service logs --tail=200 -f ${SERVICE}_${SERVICE}
    ;;

  "bash")
    docker container exec -it $(docker ps | grep ${SERVICE}_${SERVICE}.1 | awk '{print $1}') bash
    ;;
  *)
    echo "Usage: $0 (build|up|start|stop|restart|log|logs|bash)"
esac
