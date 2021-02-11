#!/bin/bash

sources=(
"https://picsum.photos/"
"https://source.unsplash.com/random/"
)

url=${sources[$RANDOM % ${#sources[@]} ]}
dimension=$(xdpyinfo | awk '/dimensions/ {print $2}')

if [[ ${url} == "https://picsum.photos/" ]]; then
   dimension=$(echo $dimension | sed -e 's/x/\//g')
   echo "Picsum"
fi

wget -q -O /tmp/wallpaper.jpg ${url}${dimension}

gsettings set org.gnome.desktop.background picture-uri file:////tmp/wallpaper.jpg
