print("=== 2. CONDICIONALES Y BUCLES ===")

# 1. Condicionales (if / elif / else)
cpu_actual = 82
memoria_actual = 70
mantenimiento_activo = False

if mantenimiento_activo:
    estado = "EN MANTENIMIENTO - Alertas silenciadas"
elif cpu_actual >= 85 or memoria_actual >= 90:
    estado = "CRÍTICO - Escalar instancias de inmediato"
elif cpu_actual >= 75 and not mantenimiento_activo:
    estado = "ADVERTENCIA - Monitorear carga de CPU"
else:
    estado = "SALUDABLE - Operando dentro de parámetros"

print(f"Estado del nodo (CPU {cpu_actual}%, RAM {memoria_actual}%): {estado}\n")

# 2. Bucle for con enumerate()
servicios = ["nginx", "postgres", "redis", "worker-celery"]
print("Verificando servicios registrados:")
for indice, servicio in enumerate(servicios, start=1):
    print(f"  [{indice}] Servicio '{servicio}' -> OK")

# 3. Bucle while con continue y break (simulación de reintentos)
print("\nSimulando conexión a base de datos:")
intento = 0
max_intentos = 5
conectado = False

while intento < max_intentos:
    intento += 1
    if intento == 2:
        print(f"  Intento {intento}: Timeout temporal, reintentando...")
        continue  # Salta al siguiente ciclo
    if intento == 3:
        print(f"  Intento {intento}: Conexión establecida exitosamente.")
        conectado = True
        break  # Detiene el bucle al lograr el objetivo
    print(f"  Intento {intento}: Conectando...")

if not conectado:
    print("  No fue posible establecer conexión.")