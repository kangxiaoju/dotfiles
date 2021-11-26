#!/bin/bash

while true; do
  sleep 60 && sed -i "3c $(curl -s http://wttr.in/shanghai?format=1)" ~/scripts/config   
done
