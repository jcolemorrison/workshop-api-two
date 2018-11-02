#!/usr/bin/env bash

# using Circle CI bash to access sourced environment variables

TASK_DEFINITION="trialthree-api-task-def"

set -e

echo "Building image ..."

docker build -t $IMAGE:$CIRCLE_SHA1 -t $IMAGE:latest .

eval $(aws ecr get-login --no-email --region $AWS_DEFAULT_REGION)

docker push $IMAGE:latest
docker push $IMAGE:$CIRCLE_SHA1

echo "Updating service ..."

# Get current task definition as base of the update
aws ecs describe-task-definition --task-definition $TASK_DEFINITION >> base.json

# Exit if the base.json file fails to populate

if [ ! -f ./base.json ]; then
  echo "base.json not found!"
  exit 1
fi

# Create updated task file at file://update-task.json that we'll make shortly
node ./create-updated-task.js

# Exit if the updated file fails to populate
if [ ! -f ./base.json ]; then
  echo "base.json not found!"
  exit 1
fi

aws ecs register-task-definition --cli-input-json file://updated-task.json

aws ecs update-service --cluster trialthree --service trialthree-api --task-definition $TASK_DEFINITION

# remove temp files

rm ./base.json
rm ./updated-task.json
