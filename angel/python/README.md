
## 1. Entorno virtual y .gitignore (`01_venv_gitignore.sh`)

Comandos ejecutados en PowerShell (equivalentes al script de bash):

```powershell
python --version
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -c "import sys; print(sys.executable)"
Add-Content .gitignore ".venv/"
```

Salida:

```text
Python 3.10.7
Successfully installed pip-26.3
C:\Users\57316\Desktop\Laboratorios-CL Camp\python\.venv\Scripts\python.exe
```


## 2. Variables, tipos de datos y operadores (`02_variables.py`)

```text
<class 'int'>
8081
False
3 1
web-01:8080 activo=True
```

## 3. Condicionales y bucles (`03_condicionales_bucles.py`)

```text
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

```text
{200: 2, 404: 1, 500: 1}
2
```

## 5. Funciones y manejo de errores (`05_funciones_errores.py`)

```text
12.5
Advertencia: total es 0
0.0
Dato inválido: unsupported operand type(s) for /: 'str' and 'int'
None
```

## 6. Lectura y escritura de archivos, CSV (`06_archivos_csv.py`)

Genera `servidores.txt` y `reporte.csv`. Al final imprime el CSV para verificarlo:

```text
servidor,estado
web-01,ok
web-02,error
```
