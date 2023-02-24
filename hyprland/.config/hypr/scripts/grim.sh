#!/bin/bash

color(){
  grim -g "$(slurp -p)" -t ppm - | convert - -format '$[pixel:p{0,0}]' txt:- | wl-copy
}

slurp(){
  grim -g "$(slurp)" - | wl-copy
}

echo $1
$1
