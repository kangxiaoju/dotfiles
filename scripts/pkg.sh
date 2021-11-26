#!/bin/bash

while true; do
  sleep 10 && sed -i "5c $(checkupdates | wc -l)" ~/scripts/config
done
