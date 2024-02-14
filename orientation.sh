#!/bin/bash

# Made by Diego Jurado Segui (diejuse) for Maemo Leste. 2024
# github.com/diejuse

# Obtener la información de la pantalla usando xrandr
resolution=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+')

# Buscar la orientación actual de la pantalla
width="${resolution%%x*}"
height="${resolution##*x}"

# Verificar la orientación y mostrar el resultado
if [ $width -gt $height ]; then
  echo "landscape"
  dbus-send --system --type=signal /com/nokia/mce/signal com.nokia.mce.signal.sig_device_orientation_ind string:'landscape'
else
  echo "portrait"
  dbus-send --system --type=signal /com/nokia/mce/signal com.nokia.mce.signal.sig_device_orientation_ind string:'portrait'
fi
