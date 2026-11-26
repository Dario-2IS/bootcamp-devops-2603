import requests

# Antes de ejecutar esto, la app debe estar corriendo con: flask --app hello run
# Desde macOS Monterey, el puerto 5000 lo usa AirPlay Receiver, y Flask puede fallar o responder 403. Para evitarlo, usa el puerto 5001
r = requests.get("http://127.0.0.1:5001/")

print("Status:", r.status_code)
print("Respuesta:", r.text)
