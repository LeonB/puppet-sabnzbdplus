#!/bin/bash

#http://wiki.sabnzbd.org/user-scripts

if [ "$5" != "0" ]; then
  exit 1;
fi

if [ "$5" = "movies" ]; then
  mv -fv "$1" /media/freenas/movies/
elif [ "$5" = "music" ]; then
  mv -fv "$1" /media/freenas/music/ter_uwer_goedkeuring/
#elif [ "$5" = "tv" ]; then
# mv -fv "$1" /mnt/point/tv
#elif [ "$5" = "etc" ]; then
# etc.
fi
