from pathlib import Path

# 1. Variables
nombre = "Luis"
curso = "DevOps"
horas_estudio = 5

print(f"Estudiante: {nombre}")
print(f"Curso: {curso}")
print(f"Horas de estudio: {horas_estudio}")

# 2. Condicionales
if horas_estudio >= 5:
    print("Objetivo de estudio cumplido.")
else:
    print("Todavía faltan horas de estudio.")

# 3. Estructuras de datos: lista y diccionario
herramientas = ["Linux", "Git", "Python"]

estudiante = {
    "nombre": nombre,
    "curso": curso,
    "horas": horas_estudio,
}

# 4. Bucle
print("\nHerramientas del curso:")
for herramienta in herramientas:
    print(f"- {herramienta}")

# 5. Función
def crear_resumen(datos):
    return (
        f"{datos['nombre']} estudia {datos['curso']} "
        f"durante {datos['horas']} horas."
    )


resumen = crear_resumen(estudiante)
print(f"\nResumen: {resumen}")

# 6. Escritura, lectura y manejo de errores
archivo = Path(__file__).with_name("resultado.txt")

try:
    archivo.write_text(resumen + "\n", encoding="utf-8")
    contenido = archivo.read_text(encoding="utf-8")
    print(f"\nContenido de {archivo.name}:")
    print(contenido)
except OSError as error:
    print(f"No se pudo escribir o leer el archivo: {error}")
