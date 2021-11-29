#!/bin/bash

while true; do
  sleep 10 && sed -i "4c $(checkupdates | wc -l)" ~/scripts/config
done
