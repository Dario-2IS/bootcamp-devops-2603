# Inspector de certificados TLS/SSL

Este script permite ingresar hasta tres dominios válidos y analizar su conexión HTTPS y certificado TLS/SSL.

## Requisitos

- Bash
- `curl`
- `openssl`

## Ejecución

Ejecuta el script:

```bash
bash "network_inspector.sh"
```

La terminal solicitará un dominio a la vez:

```text
Ingrese un dominio (0/3, Enter para finalizar): chatgpt.com
Ingrese un dominio (1/3, Enter para finalizar): google.com
Ingrese un dominio (2/3, Enter para finalizar): claude.ai
```

Se pueden ingresar hasta tres dominios. Para finalizar antes de completar los tres, presiona `Enter` sin escribir ningún valor.

Si el dominio no tiene un formato válido, el script muestra un mensaje y solicita otro:

```text
Dominio no valido: dominio-invalido
```

## Resultado

Para cada dominio válido, el script muestra:

- La negociación TLS realizada por `curl`.
- El estado de respuesta HTTP.
- El nombre del dominio protegido por el certificado.
- El emisor del certificado.
- Las fechas de inicio y vencimiento.
- Si el certificado vence dentro de los próximos 30 días.

Ejemplo de salida:

```text
=== Analisis de chatgpt.com ===
--- Handshake TLS (curl) ---
* SSL connection using TLSv1.3
* subject: CN=chatgpt.com
* expire date: Feb 16 22:08:19 2027 GMT
* HTTP/2
< HTTP/2 200

--- Emisor y vigencia (openssl) ---
subject=CN=chatgpt.com
issuer=C=US, O=Google Trust Services, CN=WE1
notBefore=Nov 18 21:08:32 2026 GMT
notAfter=Feb 16 22:08:19 2027 GMT

--- ¿Expira en los próximos 30 días? ---
Certificate will not expire
```

Al finalizar el análisis de los dominios, el script realiza una prueba adicional contra `expired.badssl.com` para comprobar el comportamiento frente a un certificado expirado:

```text
=== Prueba con certificado expirado ===
curl: (60) SSL certificate problem: certificate has expired
```