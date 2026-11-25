# Tarea 04: Scripts Bash

## `monitoreo.sh`

Muestra el uso de CPU, memoria y disco. También muestra una alerta cuando alguna métrica supera el umbral configurado (80%).

```bash
bash monitoreo.sh
```

Resultado:

```text
CPU Load: 3.61%
Memory Usage: 97.49%
Disk Usage: 4%
Alert: One of the metrics is above 80%
```

Los valores dependen del estado actual del equipo.

## `read&print.sh`

Solicita un valor por teclado y luego lo imprime.

```bash
bash "read&print.sh"
```

Ejemplo:

```text
Ingrese una variable: (:
La variable ingresada es: (:
```