
#!/bin/bash


while true; do

  #[ $interval == 0 ] || [ $(($interval % 3600)) == 0 ]
  #interval=$((interval + 1))

  #sleep 1 && xsetroot -name "$(alsa) $(disk) $(mem) $(cpu) $(clock)$(pkg_updates) $(keyboard)"
  sleep 1 && sh ~/scripts/dwm-status-refresh.sh
done
