# Python — Fundamentos para DevOps

Esta carpeta contiene ejercicios introductorios de Python orientados al perfil DevOps. Cada script cubre un concepto esencial del lenguaje aplicado a contextos reales como gestión de servidores, análisis de códigos HTTP y generación de reportes.

---

## Archivos

### `variables_tipos_operadores.py`
Variables de los cuatro tipos básicos (`str`, `int`, `float`, `bool`), operadores aritméticos, de comparación y f-strings.

```
<class 'int'>
8081
False
3 1
web-01:8080 activo=True
```

---

### `condicionales_bucles.py`
Clasificación de códigos HTTP con `if/elif/else` y un bucle `while` para simular reintentos de conexión.

```
200: OK
404: error del cliente
500: error del servidor
200: OK
503: error del servidor
Reintento 1
Reintento 2
Reintento 3
```

---

### `estructuras_datos.py`
Las cuatro estructuras de datos principales: lista (mutable, ordenada), tupla (inmutable), diccionario (clave-valor) y set (sin duplicados).

```
{200: 2, 404: 1, 500: 1}
2
```

---

### `funciones_manejo_errores.py`
Definición de funciones con docstring y manejo de excepciones (`ZeroDivisionError`, `TypeError`).

```
12.5
Advertencia: total es 0
0.0
Dato inválido: unsupported operand type(s) for /: 'str' and 'int'
None
```

---

### `lectura_escritura_archivos.py`
Lectura y escritura de archivos de texto plano y CSV usando el módulo estándar `csv`. Genera `servidores.txt` y `reporte.csv` al ejecutarse.

```
(sin salida en consola)
```

---

## Requisitos

- Python 3.x

## Ejecución

```bash
python3 <nombre_del_archivo>.py
```
