# Fundamentos de Python

Práctica de conceptos fundamentales de Python organizada en scripts independientes dentro de un entorno virtual aislado (`venv`).

## Estructura de la carpeta

```text
python/
├── .gitignore
├── README.md
├── 01_variables.py
├── 02_condicionales_bucles.py
├── 03_estructuras_datos.py
├── 04_funciones_errores.py
└── 05_archivos.py
```

## Requisitos previos

- Python 3.10 o superior instalado.

## Configuración del entorno virtual (`venv`)

1. Ubicarse dentro de la carpeta `python/`:
   ```bash
   cd python
   ```

2. Crear el entorno virtual:
   ```bash
   python3 -m venv venv
   ```

3. Activar el entorno virtual:
   - **Linux / macOS / WSL:**
     ```bash
     source venv/bin/activate
     ```
   - **Windows (PowerShell):**
     ```powershell
     .\venv\Scripts\Activate.ps1
     ```

4. Para desactivar el entorno al finalizar:
   ```bash
   deactivate
   ```

## Ejecución de los scripts

Con el entorno virtual activo, ejecutar cada archivo desde la terminal:

```bash
python 01_variables.py
python 02_condicionales_bucles.py
python 03_estructuras_datos.py
python 04_funciones_errores.py
python 05_archivos.py
```

## Descripción de los archivos

| Archivo | Contenido |
| :--- | :--- |
| `.gitignore` | Excluye el entorno virtual (`venv/`), archivos de caché (`__pycache__/`) y archivos generados en pruebas. |
| `01_variables.py` | Declaración de variables, tipos de datos básicos (`str`, `int`, `float`, `bool`, `None`), constantes, conversión de tipos y `f-strings`. |
| `02_condicionales_bucles.py` | Estructuras condicionales (`if`, `elif`, `else`), operadores lógicos, bucles `for` con `enumerate()` y bucles `while` con `break` y `continue`. |
| `03_estructuras_datos.py` | Uso y manipulación de listas (`list`), tuplas (`tuple`), conjuntos (`set`) y diccionarios (`dict`). |
| `04_funciones_errores.py` | Definición de funciones con parámetros por defecto y *type hints*, lanzamiento de excepciones (`raise`) y captura de errores (`try`, `except`, `else`, `finally`). |
| `05_archivos.py` | Lectura y escritura de archivos de texto (`.txt`) y formato `JSON` utilizando gestores de contexto (`with open`) y `pathlib`. |