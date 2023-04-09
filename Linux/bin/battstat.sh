#!/usr/bin/env bash

POWER_SUPPLY_NAME=$(find /sys/class/power_supply/ -maxdepth 1 -name 'BAT*' | cut -d'/' -f5)
if [ ! -z $POWER_SUPPLY_NAME ]; then 
    BATTERY_STATUS=$(cat /sys/class/power_supply/$POWER_SUPPLY_NAME/status)
    if [ $BATTERY_STATUS == "Charging" ]; then
        echo ▲ `cat /sys/class/power_supply/$POWER_SUPPLY_NAME/capacity`%
    else
        echo ▼ `cat /sys/class/power_supply/$POWER_SUPPLY_NAME/capacity`%
    fi
fi
