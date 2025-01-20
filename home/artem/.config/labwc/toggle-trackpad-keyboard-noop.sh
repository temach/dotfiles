#!/bin/env bash

# must add with visudo to run sudo without password prompt:
# artem ALL=(ALL) NOPASSWD: /bin/mv /etc/keyd/15-forces-noop.conf /etc/keyd/15-forces-noop.conf.disabled
# artem ALL=(ALL) NOPASSWD: /bin/mv /etc/keyd/15-forces-noop.conf.disabled /etc/keyd/15-forces-noop.conf
# artem ALL=(ALL) NOPASSWD: /bin/systemctl restart keyd

set -euxo pipefail


# gnu awk has inplace extension
# sub returns 0 or 1 depending on if it modified $0 string
gawk -i inplace '
BEGIN { done_once = 0 }
{
    if (! done_once) { done_once = sub("<sendEventsMode>no</sendEventsMode>", "<sendEventsMode>yes</sendEventsMode>") }
    if (! done_once) { done_once = sub("<sendEventsMode>yes</sendEventsMode>", "<sendEventsMode>no</sendEventsMode>") }
    print;
}
' ~/.config/labwc/rc.xml

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
