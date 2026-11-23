print("=== 4. FUNCIONES Y MANEJO DE ERRORES ===")


def calcular_disponibilidad(tiempo_total_min: float, tiempo_caida_min: float = 0.0) -> float:
    """Calcula el porcentaje de disponibilidad (SLA) de un servicio."""
    if tiempo_total_min <= 0:
        raise ValueError("El tiempo total debe ser mayor a 0 minutos.")
    if tiempo_caida_min < 0 or tiempo_caida_min > tiempo_total_min:
        raise ValueError("El tiempo de caída no puede ser negativo ni mayor al tiempo total.")

    tiempo_operativo = tiempo_total_min - tiempo_caida_min
    return (tiempo_operativo / tiempo_total_min) * 100


def dividir_carga(peticiones_totales: int, servidores: int) -> float:
    """Divide peticiones entre servidores manejando errores de ejecución."""
    try:
        resultado = peticiones_totales / servidores
    except ZeroDivisionError:
        print("  [ERROR] No se puede dividir entre 0 servidores activos.")
        return 0.0
    except TypeError as err:
        print(f"  [ERROR] Tipo de dato inválido: {err}")
        return 0.0
    else:
        print("  [OK] Cálculo de balanceo ejecutado sin errores.")
        return resultado
    finally:
        print("  [INFO] Finalizó verificación de balanceo.")


# Caso 1: Ejecución válida de SLA
try:
    sla = calcular_disponibilidad(tiempo_total_min=43200, tiempo_caida_min=15)
    print(f"Disponibilidad mensual calculada: {sla:.3f}%")
except ValueError as error:
    print(f"Error de validación: {error}")

# Caso 2: Captura de error controlado con raise
try:
    calcular_disponibilidad(tiempo_total_min=100, tiempo_caida_min=150)
except ValueError as error:
    print(f"Excepción capturada correctamente: {error}")

# Caso 3: Manejo de división por cero
print("\nProbando balanceo de carga con 0 servidores:")
dividir_carga(1000, 0)

print("\nProbando balanceo de carga con 4 servidores:")
carga = dividir_carga(1000, 4)
print(f"Peticiones por servidor: {carga}")