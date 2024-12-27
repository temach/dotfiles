#!/bin/env bash

# must add with visudo to run sudo without password prompt:
# artem ALL=(ALL) NOPASSWD: /bin/mv /etc/keyd/15-forces-noop.conf /etc/keyd/15-forces-noop.conf.disabled
# artem ALL=(ALL) NOPASSWD: /bin/mv /etc/keyd/15-forces-noop.conf.disabled /etc/keyd/15-forces-noop.conf
# artem ALL=(ALL) NOPASSWD: /bin/systemctl restart keyd

set -euxo pipefail


# "t" is sed branching, see https://getdocs.org/Sed/Branching-and-flow-control
sed -i -e 's@<sendEventsMode>no</sendEventsMode>@<sendEventsMode>yes</sendEventsMode>@ ; t ; s@<sendEventsMode>yes</sendEventsMode>@<sendEventsMode>no</sendEventsMode>@' ~/.config/labwc/rc.xml 

labwc --reconfigure 


fn="/etc/keyd/15-forces-noop.conf"

if [ -f $fn.disabled ] ; then 
    sudo /bin/mv $fn.disabled  $fn
elif [ -f $fn ] ; then
    sudo /bin/mv $fn  $fn.disabled
else 
    echo "Error, can not find $fn or $fn.disabled files."
fi

sudo /bin/systemctl restart keyd
