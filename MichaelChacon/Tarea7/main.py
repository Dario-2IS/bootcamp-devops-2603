from utils.red import verificar_conexion, obtener_ip

if __name__ == "__main__":
    print(f"¿Hay conexión a internet?: {verificar_conexion()}")
    dominio = "github.com"
    print(f"La IP de {dominio} es: {obtener_ip(dominio)}")
