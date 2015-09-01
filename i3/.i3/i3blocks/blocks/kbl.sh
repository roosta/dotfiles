#!/bin/bash
# fix th
# source: http://unix.stackexchange.com/a/27688
case "$(xset -q|grep LED| awk '{ print $10 }')" in
  "00000000") KBD="US" ;;
  "00000002") KBD="US" ;;
  "00001000") KBD="NO" ;;
  "00001002") KBD="NO" ;;
  *) KBD="unknown" ;;
esac
echo $KBD
echo "#305D5F"
