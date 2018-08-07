#!/bin/bash
echo lo: $(ifconfig|head -n $((($(ifconfig |grep -nT 'lo'|awk '{print $1}')+1))) |tail -n 1|awk '{print $2 }'|sed -e 's/addr://') ⭍ wl:  $(ifconfig|head -n $((($(ifconfig |grep -nT 'wl'|awk '{print $1}')+1))) |tail -n 1|awk '{print $2 }'|sed -e 's/addr://')
