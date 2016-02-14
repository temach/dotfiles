#!/usr/bin/bash
# this is called by cbatticon when battery charge reaches critical level
DISPLAY=:0.0 /usr/bin/twmnc -l twmn.battery_low.conf -t "Battery Power..." -c "... its low dude!"
