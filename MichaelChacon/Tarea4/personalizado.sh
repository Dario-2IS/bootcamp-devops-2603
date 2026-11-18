#!/bin/bash

if [ -n "$1" ]; then
    variable="$1"
else
    read -p "Por favor, introduce una variable o mensaje: " variable
fi

echo "------------------------------------------"
echo "El valor de la variable es: $variable"
echo "------------------------------------------"
