#!/bin/bash

set -eo pipefail

if [ $(echo ${GITHUB_REPOSITORY} | wc -c) -eq 1 ] ; then
  echo -e "\033[31mRepository cannot be empty\033[0m"
  exit 1
fi

curl --request GET \
  --url https://api.github.com/repos/${GITHUB_REPOSITORY}/milestones \
  --header "Authorization: Bearer ${GITHUB_TOKEN}" \
  --header 'Content-Type: application/json' \
  -o /workdir/response.json \
  -s

sleep 3

printf "::set-output name=milestones::%s" $(cat /workdir/response.json | jq .number)
