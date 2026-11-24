import requests

# Antes de ejecutar esto, la app debe estar corriendo con: flask --app hello run
r = requests.get("http://127.0.0.1:5000/")

print("Status:", r.status_code)
print("Respuesta:", r.text)
