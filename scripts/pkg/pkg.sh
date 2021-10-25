#!/bin/bash

while true; do
  sleep 10 && echo "$(checkupdates | wc -l)" > ~/scripts/pkg/pkg
done
