#!/bin/bash
nohup celery -A geonode.celery_app:app beat -l DEBUG -f /var/log/celery.log &>/dev/null &
nohup celery -A geonode.celery_app:app worker --without-gossip --without-mingle -Ofair -B -E --statedb=worker.state -s celerybeat-schedule --loglevel=INFO --concurrency=10 -n worker1@%h -f /var/log/celery.log &>/dev/null &
nohup celery -A geonode.celery_app:app flower --auto_refresh=True --debug=False --broker=${BROKER_URL} --basic_auth=${ADMIN_USERNAME}:${ADMIN_PASSWORD} --address=0.0.0.0 --port=5555 &>/dev/null &
