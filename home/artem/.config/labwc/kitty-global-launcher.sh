#!/bin/zsh
# see also: https://github.com/kovidgoyal/kitty/discussions/7936

# this file is set during desktop switch in labwc rc.xml
unique_title=kitty_labwc_workspace_$(cat /tmp/labwc-current-workspace)
echo $unique_title

# see: https://git.sr.ht/~brocellous/wlrctl#features-and-examples
# focus kitty or start it
wlrctl window focus title:$unique_title || kitty --title $unique_title --detach --directory="~" -o allow_remote_control=socket-only --listen-on unix:/tmp/$unique_title

# make a new tab
kitten @ launch --type=tab --to unix:/tmp/$unique_title
