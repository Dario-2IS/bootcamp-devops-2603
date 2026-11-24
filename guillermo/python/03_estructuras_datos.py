print("=== 3. ESTRUCTURAS DE DATOS ===")

# 1. LISTAS (mutables, ordenadas)
ambientes = ["dev", "qa", "staging"]
ambientes.append("prod")
ambientes_mayus = [amb.upper() for amb in ambientes]  # List comprehension
print(f"Lista de ambientes: {ambientes} -> En mayúsculas: {ambientes_mayus}")

# 2. TUPLAS (inmutables, ideales para registros fijos)
endpoint_db: tuple[str, int, str] = ("10.0.1.25", 5432, "postgresql")
host, puerto, motor = endpoint_db  # Desempaquetado (unpacking)
print(f"Tupla desempaquetada -> Motor: {motor}, Host: {host}, Puerto: {puerto}")

# 3. CONJUNTOS / SETS (sin duplicados, operaciones de conjuntos)
puertos_abiertos_fw = {22, 80, 443, 8080, 80, 443}  # Elimina duplicados automáticamente
puertos_requeridos = {80, 443, 5432}

faltantes = puertos_requeridos - puertos_abiertos_fw
comunes = puertos_requeridos & puertos_abiertos_fw
print(f"Set puertos únicos abiertos: {puertos_abiertos_fw}")
print(f"Puertos requeridos ya abiertos: {comunes} | Faltantes: {faltantes}")

# 4. DICCIONARIOS (clave-valor)
servidor = {
    "hostname": "web-srv-01",
    "ip": "192.168.10.14",
    "activo": True,
    "etiquetas": ["linux", "docker", "production"],
}
servidor["region"] = "us-east-1"

print("\nDetalle del diccionario 'servidor':")
for clave, valor in servidor.items():
    print(f"  - {clave}: {valor}")

# Uso seguro de .get() para claves que podrían no existir
owner = servidor.get("owner", "equipo-devops")
print(f"Responsable (con .get): {owner}")