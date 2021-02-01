#!/bin/bash

dimension=$(xdpyinfo | awk '/dimensions/ {print $2}')

wget -O /tmp/wallpaper.jpg "https://source.unsplash.com/random/${dimension}"

gsettings set org.gnome.desktop.background picture-uri file:////tmp/wallpaper.jpg
