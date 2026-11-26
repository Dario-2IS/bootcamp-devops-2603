import socket
import subprocess

def verificar_conexion(host="8.8.8.8"):
    resultado = subprocess.run(
        ["ping", "-c", "1", host],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL
    )
    return resultado.returncode == 0

def obtener_ip(dominio):
    try:
        return socket.gethostbyname(dominio)
    except socket.gaierror:
        return "No se pudo resolver el dominio"
