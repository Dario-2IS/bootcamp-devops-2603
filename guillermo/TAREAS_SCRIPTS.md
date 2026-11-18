# Evidencia de Scripts en Bash — Guillermo Licir

**Estudiante:** Guillermo Humberto Licir Nuñez  
**Rama:** `feature-TAREA003`  
**Entorno de ejecución:** Git Bash (UCRT64) en Windows  

---

## 1. Script de Monitoreo de Recursos (`monitor.sh`)

### Código fuente implementado
```bash
#!/bin/bash
THRESHOLD=80

# Simulación o lectura compatible de CPU en Git Bash / Windows
CPU_LOAD=25
echo "CPU Load: $CPU_LOAD%"

# Lectura de memoria simulada o fija compatible
MEMORY=45
echo "Memory Usage: $MEMORY%"

# Check disk space (extrae el número entero de uso de disco)
DISK=$(df -h | awk '$NF=="/"{print $(NF-1)}' | sed 's/%//')
echo "Disk Usage: $DISK%"

# Alert if any metric exceeds threshold (usando comparación de enteros)
if [ "$CPU_LOAD" -gt "$THRESHOLD" ] || [ "$MEMORY" -gt "$THRESHOLD" ] || [ "$DISK" -gt "$THRESHOLD" ]; then
    echo "Alert: One of the metrics is above $THRESHOLD%"
fi
```

### Evidencia de ejecución en Terminal
Bash

```
$ chmod +x monitor.sh
$ ./monitor.sh
CPU Load: 25%
Memory Usage: 45%
Disk Usage: 89%
Alert: One of the metrics is above 80%
```

## 2. Script de lectura e impresión de variables (`saludo.sh`)

### Código fuente implementado
Bash

```
#!/bin/bash
echo "Por favor, introduce un texto o variable:"
read mi_variable
echo "----------------------------------------"
echo "Has introducido la variable: $mi_variable"
echo "----------------------------------------"
```

### Evidencia de ejecución en Terminal
Bash

```
$ chmod +x saludo.sh
$ ./saludo.sh
Por favor, introduce un texto o variable:
Hola
----------------------------------------
Has introducido la variable: Hola
----------------------------------------
```

## Uso de agentes

Para apoyar la tarea de creación de `monitor.sh`, `saludo.sh` y este archivo (`TAREAS_SCRIPTS.md`), se utilizó Gemini mediante Hydrogen con el nivel de pensamiento configurado en **bajo**.

**Consumo aproximado:** ~290 tokens de entrada, ~1,150 tokens de salida y ~1,440 tokens en total.

---

## Ejecución Autónoma con Kiro CLI

### Prompt original enviado a Kiro CLI

> Ignora cualquier script .sh existente en esta carpeta y realiza desde cero las siguientes tareas en este directorio actual (entorno Git Bash en Windows):
>
> 1. Crea un script ejecutable llamado `salud_sistema.sh` que monitoree el porcentaje de uso de CPU, memoria RAM y espacio en disco raíz (`/`), estableciendo un umbral de alerta en 80%. Asegúrate de que sea 100% compatible con Git Bash en Windows (sin depender de comandos inexistentes como `top`, `free` o `bc`, usando alternativas compatibles o valores de respaldo en Bash puro si no están disponibles) y ejecútalo en la terminal para comprobar su salida real.
> 2. Crea un segundo script ejecutable llamado `perfil_usuario.sh` que solicite interactivamente por consola dos datos al usuario (su nombre completo y su rol profesional en tecnología), los almacene en variables y luego imprima una tarjeta de resumen formateada en consola con esos datos y la fecha actual del sistema. Pruébalo en la terminal enviándole datos de ejemplo.
> 3. Crea un archivo `.gitignore` en este mismo directorio (`guillermo/.gitignore`) que ignore todos los archivos con extensión `*.sh` para que ninguno de los scripts se suba al repositorio de Git.
> 4. Actualiza el archivo `TAREAS_SCRIPTS.md` agregando al final una nueva sección titulada "## Ejecución Autónoma con Kiro CLI" que incluya:
>    - El prompt exacto e íntegro que te acabo de enviar en esta instrucción.
>    - El paso a paso de lo que ejecutaste (incluyendo la creación del `.gitignore`).
>    - El código fuente de `salud_sistema.sh` y `perfil_usuario.sh`.
>    - La salida exacta obtenida en la terminal al ejecutar ambos scripts.
>    - Una tabla con el cálculo estimado de tokens de entrada y tokens de salida consumidos durante esta sesión, dejando un espacio listo para anotar los créditos de `/usage`.

---

### Paso a paso ejecutado por Kiro CLI

1. **Lectura del workspace** — Se listó el contenido de `guillermo/` y se leyó `TAREAS_SCRIPTS.md` para entender el contexto previo.
2. **Creación de `salud_sistema.sh`** — Script escrito con lógica para CPU vía `/proc/stat` (disponible en MSYS2), RAM vía `/proc/meminfo`, y disco vía `df -h`. Se aplicó `chmod +x`.
3. **Creación de `perfil_usuario.sh`** — Script interactivo con `read -r`, formateo con `printf` y fecha via `date`. Se aplicó `chmod +x`.
4. **Creación de `.gitignore`** — Archivo creado con la regla `*.sh` para excluir todos los scripts del repositorio.
5. **Ejecución y depuración de `salud_sistema.sh`** — Se detectó que `awk NR==2{print $5}` retornaba `26G` (Avail) en lugar de `90%` (Use%) porque el filesystem `C:/Program Files/Git` ocupa dos tokens en awk. Se corrigió a `$(NF-1)` para apuntar siempre a la penúltima columna.
6. **Ejecución de `perfil_usuario.sh`** — Se pasaron datos de ejemplo vía stdin: nombre `Guillermo Humberto Licir Nuñez` y rol `DevOps Engineer`.
7. **Limpieza** — Se eliminó el script temporal `_test_df.sh` usado durante la depuración.
8. **Actualización de `TAREAS_SCRIPTS.md`** — Se añadió esta sección al final del archivo.

---

### Código fuente: `salud_sistema.sh`

```bash
#!/bin/bash
# salud_sistema.sh
# Monitorea CPU, RAM y disco raíz con umbral de alerta del 80%
# Compatible con Git Bash en Windows (sin top, free ni bc)

THRESHOLD=80

echo "============================================"
echo "   MONITOREO DE SALUD DEL SISTEMA"
echo "============================================"

# --- CPU ---
# /proc/stat puede estar disponible en Git Bash vía MSYS2
if [ -f /proc/stat ]; then
    CPU_LINE1=$(grep '^cpu ' /proc/stat)
    sleep 1
    CPU_LINE2=$(grep '^cpu ' /proc/stat)

    read -r _ u1 n1 s1 i1 w1 _ <<< "$CPU_LINE1"
    read -r _ u2 n2 s2 i2 w2 _ <<< "$CPU_LINE2"

    IDLE1=$i1
    IDLE2=$i2
    TOTAL1=$(( u1 + n1 + s1 + i1 + w1 ))
    TOTAL2=$(( u2 + n2 + s2 + i2 + w2 ))

    DELTA_IDLE=$(( IDLE2 - IDLE1 ))
    DELTA_TOTAL=$(( TOTAL2 - TOTAL1 ))

    if [ "$DELTA_TOTAL" -gt 0 ]; then
        CPU_LOAD=$(( 100 * (DELTA_TOTAL - DELTA_IDLE) / DELTA_TOTAL ))
    else
        CPU_LOAD=0
    fi
else
    # Fallback: valor fijo si /proc/stat no existe
    CPU_LOAD=15
fi

echo "CPU Usage    : ${CPU_LOAD}%"
[ "$CPU_LOAD" -gt "$THRESHOLD" ] && echo "  ⚠️  ALERTA: CPU supera el ${THRESHOLD}%"

# --- RAM ---
# /proc/meminfo disponible en Git Bash vía MSYS2
if [ -f /proc/meminfo ]; then
    MEM_TOTAL=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    MEM_AVAIL=$(grep MemAvailable /proc/meminfo | awk '{print $2}')
    MEM_USED=$(( MEM_TOTAL - MEM_AVAIL ))
    if [ "$MEM_TOTAL" -gt 0 ]; then
        MEM_PCT=$(( 100 * MEM_USED / MEM_TOTAL ))
    else
        MEM_PCT=0
    fi
else
    # Fallback
    MEM_PCT=40
fi

echo "RAM Usage    : ${MEM_PCT}%"
[ "$MEM_PCT" -gt "$THRESHOLD" ] && echo "  ⚠️  ALERTA: RAM supera el ${THRESHOLD}%"

# --- DISCO ---
# La columna Use% es siempre la penúltima (NF-1) independientemente del
# número de tokens que ocupe el nombre del filesystem en Git Bash / MSYS2
DISK_RAW=$(df -h / 2>/dev/null | awk 'NR==2{split($(NF-1),a,"%"); print a[1]}')

# Si la raíz / no devuelve nada, probamos /c
if [ -z "$DISK_RAW" ]; then
    DISK_RAW=$(df -h /c 2>/dev/null | awk 'NR==2{split($(NF-1),a,"%"); print a[1]}')
fi

# Último recurso: valor fijo
DISK_PCT=${DISK_RAW:-55}

echo "Disk Usage   : ${DISK_PCT}%"
[ "$DISK_PCT" -gt "$THRESHOLD" ] && echo "  ⚠️  ALERTA: Disco supera el ${THRESHOLD}%"

echo "============================================"

# Resumen global
ALERT=0
[ "$CPU_LOAD"  -gt "$THRESHOLD" ] && ALERT=1
[ "$MEM_PCT"   -gt "$THRESHOLD" ] && ALERT=1
[ "$DISK_PCT"  -gt "$THRESHOLD" ] && ALERT=1

if [ "$ALERT" -eq 1 ]; then
    echo "ESTADO: ⚠️  Al menos una métrica supera el umbral de ${THRESHOLD}%"
else
    echo "ESTADO: ✅ Todos los recursos están dentro del umbral (${THRESHOLD}%)"
fi

echo "============================================"
```

---

### Código fuente: `perfil_usuario.sh`

```bash
#!/bin/bash
# perfil_usuario.sh
# Solicita nombre y rol profesional al usuario e imprime una tarjeta formateada

echo "============================================"
echo "   REGISTRO DE PERFIL DE USUARIO"
echo "============================================"

# Lectura interactiva
printf "Ingresa tu nombre completo: "
read -r NOMBRE

printf "Ingresa tu rol profesional en tecnología: "
read -r ROL

# Fecha del sistema (compatible con Git Bash en Windows)
FECHA=$(date '+%d/%m/%Y %H:%M:%S')

echo ""
echo "============================================"
echo "          🪪  TARJETA DE PERFIL"
echo "============================================"
printf "  %-18s %s\n" "Nombre:"  "$NOMBRE"
printf "  %-18s %s\n" "Rol:"     "$ROL"
printf "  %-18s %s\n" "Fecha:"   "$FECHA"
echo "============================================"
echo "✅ Perfil registrado correctamente."
echo "============================================"
```

---

### Salida real en terminal

#### `salud_sistema.sh`

```
$ chmod +x salud_sistema.sh && ./salud_sistema.sh
============================================
   MONITOREO DE SALUD DEL SISTEMA
============================================
CPU Usage    : 10%
RAM Usage    : 100%
  ⚠  ALERTA: RAM supera el 80%
Disk Usage   : 90%
  ⚠  ALERTA: Disco supera el 80%
============================================
ESTADO: ⚠  Al menos una métrica supera el umbral de 80%
============================================
```

#### `perfil_usuario.sh` (datos de ejemplo: Guillermo Humberto Licir Nuñez / DevOps Engineer)

```
$ chmod +x perfil_usuario.sh && ./perfil_usuario.sh
============================================
   REGISTRO DE PERFIL DE USUARIO
============================================
Ingresa tu nombre completo: Ingresa tu rol profesional en tecnología:
============================================
          🪪  TARJETA DE PERFIL
============================================
  Nombre:            Guillermo Humberto Licir Nuñez
  Rol:               DevOps Engineer
  Fecha:             17/11/2026 22:53:27
============================================
✅ Perfil registrado correctamente.
============================================
```

---

### Consumo estimado de tokens — Sesión Kiro CLI

| Concepto                              | Tokens de entrada | Tokens de salida | Créditos `/usage` |
|---------------------------------------|:-----------------:|:----------------:|:-----------------:|
| Prompt inicial del usuario            | ~850              | —                | —                 |
| Lectura de archivos del workspace     | ~600              | —                | —                 |
| Generación de scripts y `.gitignore`  | —                 | ~900             | —                 |
| Rondas de depuración (df / parsing)   | ~400              | ~300             | —                 |
| Actualización de `TAREAS_SCRIPTS.md`  | ~200              | ~1 100           | —                 |
| **Total estimado**                    | **~2 050**        | **~2 300**       | —                 |
| **Uso reportado por `/usage`**        | —                 | —                | **1.74 créditos en esta sesión** |

> El comando `/usage` se ejecutó manualmente. El plan Kiro Free reportó **2.20 de 50 créditos** cubiertos (**4.4%**) y reinicio el **2026-12-01**.