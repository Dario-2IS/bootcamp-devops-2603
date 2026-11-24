# Tarea 6: Python

**Autor:** Gabriel Ramírez

Todo se ejecutó en WSL con Python 3.12.3.

## 1. Entorno virtual y .gitignore

```
$ python3 --version
Python 3.12.3

$ python3 -m venv .venv
$ source .venv/bin/activate

$ python -m pip install --upgrade pip
Successfully installed pip-26.3

$ python -c "import sys; print(sys.executable)"
.../GabrielRamirez/python/.venv/bin/python
```

El `.gitignore` contiene `.venv/`, por lo que el entorno no se sube al repo.

Resultado: el entorno quedó creado y el intérprete activo es el de `.venv`.

## 2. Variables (`02_variables.py`)

```
<class 'int'>
8081
False
3 1
web-01:8080 activo=True
```

## 3. Condicionales y bucles (`03_condicionales_bucles.py`)

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

## 4. Estructuras de datos (`04_estructuras_datos.py`)

```
{200: 2, 404: 1, 500: 1}
2
```

## 5. Funciones y manejo de errores (`05_funciones_errores.py`)

```
12.5
Advertencia: total es 0
0.0
Dato inválido: unsupported operand type(s) for /: 'str' and 'int'
None
```

## 6. Lectura y escritura de archivos (`06_archivos.py`)

El script no imprime nada. Genera dos archivos, incluidos en esta carpeta como resultado del ejercicio:

- `servidores.txt`
- `reporte.csv`

## Resultado

Los seis puntos se ejecutaron sin errores y las salidas coinciden con lo esperado.
