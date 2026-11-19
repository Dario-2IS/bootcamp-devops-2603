#!/usr/bin/env bash

if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    sistema_operativo="${PRETTY_NAME:-Versión no disponible}"
else
    sistema_operativo="No se pudo identificar el sistema operativo"
fi

espacio_discos=$(df -h)

echo "=== Versión del sistema operativo ==="
echo "$sistema_operativo"

echo
echo "=== Espacio en discos ==="
echo "$espacio_discos"
