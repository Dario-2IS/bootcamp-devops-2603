# Ejecución de `monitoreo.sh`

Este script muestra el uso de CPU, memoria y disco del sistema. También
imprime una alerta cuando alguna métrica supera el umbral configurado de
80 %.

## Cómo ejecutarlo

Desde la carpeta `scripts-linux`, ejecutar:

```bash
bash monitoreo.sh
```

También se puede ejecutar desde la raíz del repositorio:

```bash
bash fmattaperdomo/scripts-linux/monitoreo.sh
```

## Respuesta obtenida

En una ejecución de ejemplo se obtuvo:

```text
CPU Load: 4.8%
Memory Usage: 8.72%
Disk Usage: 1%
```

Los valores dependen del estado del sistema en el momento de la ejecución.
Si alguna métrica supera el umbral de 80 %, el script también muestra:

```text
Alert: One of the metrics is above 80%
```

# Ejecución de `leer_variable.sh`

Este script lee un valor desde el primer parámetro recibido o, si no se
proporciona un parámetro, lo solicita por consola. Luego imprime el valor.

## Ingresar el valor por parámetro

Desde la raíz del repositorio:

```bash
bash fmattaperdomo/scripts-linux/leer_variable.sh "Hola mundo"
```

Salida:

```text
Valor ingresado: Hola mundo
```

## Ingresar el valor por consola

Ejecutar el script sin parámetros:

```bash
bash fmattaperdomo/scripts-linux/leer_variable.sh
```

El script solicita el valor:

```text
Ingrese un valor:
```

Después de ingresar `Hola desde consola` y presionar Enter, imprime:

```text
Valor ingresado: Hola desde consola
```
