# Constantes (por convención en MAYÚSCULAS)
PUERTO_DEFAULT = 8080
MAX_REINTENTOS = 3

# Tipos de datos primitivos
nombre_servicio: str = "api-pagos"
instancias_activas: int = 4
uso_cpu_porcentaje: float = 63.45
en_produccion: bool = True
ultimo_error = None  # Tipo NoneType

# Operaciones aritméticas y de cadenas
memoria_por_instancia_mb = 512
memoria_total_mb = instancias_activas * memoria_por_instancia_mb
memoria_total_gb = memoria_total_mb / 1024

url_servicio = f"https://{nombre_servicio}.interno.local:{PUERTO_DEFAULT}/health"

# Conversión de tipos (casting)
puerto_texto = "9090"
puerto_numerico = int(puerto_texto) + 1

print("=== 1. VARIABLES Y TIPOS DE DATOS ===")
print(f"Servicio: {nombre_servicio} (tipo: {type(nombre_servicio).__name__})")
print(f"Instancias: {instancias_activas} | CPU: {uso_cpu_porcentaje}%")
print(f"En producción: {en_produccion} | Último error: {ultimo_error}")
print(f"Memoria total asignada: {memoria_total_mb} MB ({memoria_total_gb:.2f} GB)")
print(f"Endpoint: {url_servicio}")
print(f"Puerto convertido desde str: {puerto_numerico} (tipo: {type(puerto_numerico).__name__})")