import json
from datetime import datetime
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
archivo_log = BASE_DIR / "registro_eventos.txt"
archivo_json = BASE_DIR / "config_servidor.json"

print("=== 5. LECTURA Y ESCRITURA DE ARCHIVOS ===")

# 1. Escritura en archivo de texto plano (modo 'w' sobrescribe / crea)
with open(archivo_log, mode="w", encoding="utf-8") as file:
    file.write(f"[{datetime.now().isoformat(timespec='seconds')}] INICIO: Despliegue iniciado\n")
    file.write(f"[{datetime.now().isoformat(timespec='seconds')}] INFO: Contenedores verificados\n")

# 2. Agregar contenido al final del archivo (modo 'a' - append)
with open(archivo_log, mode="a", encoding="utf-8") as file:
    file.write(f"[{datetime.now().isoformat(timespec='seconds')}] FIN: Despliegue completado\n")

# 3. Lectura del archivo de texto (modo 'r')
print(f"\nContenido leído desde '{archivo_log.name}':")
with open(archivo_log, mode="r", encoding="utf-8") as file:
    for numero_linea, linea in enumerate(file, start=1):
        print(f"  Línea {numero_linea}: {linea.strip()}")

# 4. Escritura y lectura de datos estructurados en JSON
configuracion = {
    "proyecto": "bootcamp-devops",
    "version": "1.0.0",
    "servicios": ["api", "db", "cache"],
    "debug": False,
}

with open(archivo_json, mode="w", encoding="utf-8") as json_file:
    json.dump(configuracion, json_file, indent=2, ensure_ascii=False)

with open(archivo_json, mode="r", encoding="utf-8") as json_file:
    datos_cargados = json.load(json_file)

print(f"\nDatos leídos desde '{archivo_json.name}':")
print(f"  Proyecto: {datos_cargados['proyecto']} | Servicios: {', '.join(datos_cargados['servicios'])}")