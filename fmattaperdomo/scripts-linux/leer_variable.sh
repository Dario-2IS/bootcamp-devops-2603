#!/bin/bash

if (($# > 1)); then
    printf 'Uso: %s [valor]\n' "$0" >&2
    exit 2
fi

if (($# == 1)); then
    variable=$1
else
    read -r -p "Ingrese un valor: " variable || {
        printf 'Error: no se pudo leer el valor de entrada.\n' >&2
        exit 1
    }
fi

printf 'Valor ingresado: %s\n' "$variable"
