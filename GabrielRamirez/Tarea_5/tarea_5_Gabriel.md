Tarea Nro 5

```
# Ver el handshake TLS y las fechas del certificado
$ curl -vI https://example.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

# Inspeccionar emisor y vigencia con openssl
$ openssl s_client -connect example.com:443 -servername example.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates

# ¿Expira en los próximos 30 días? (exit code 1 = sí)
$ openssl s_client -connect example.com:443 -servername example.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000

# Probar contra un certificado expirado real
$ curl -sS https://expired.badssl.com

```

```
# Ver el handshake TLS y las fechas del certificado
$ curl -vI https://github.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

# Inspeccionar emisor y vigencia con openssl
$ openssl s_client -connect github.com:443 -servername github.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates

# ¿Expira en los próximos 30 días? (exit code 1 = sí)
$ openssl s_client -connect github.com:443 -servername github.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000

# Probar contra un certificado expirado real
$ curl -sS https://expired.badssl.com

```

```
# Ver el handshake TLS y las fechas del certificado
$ curl -vI https://google.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

# Inspeccionar emisor y vigencia con openssl
$ openssl s_client -connect google.com:443 -servername google.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates

# ¿Expira en los próximos 30 días? (exit code 1 = sí)
$ openssl s_client -connect google.com:443 -servername google.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000

# Probar contra un certificado expirado real
$ curl -sS https://expired.badssl.com

```

```
# Ver el handshake TLS y las fechas del certificado
$ curl -vI https://cloudflare.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

# Inspeccionar emisor y vigencia con openssl
$ openssl s_client -connect cloudflare.com:443 -servername cloudflare.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates

# ¿Expira en los próximos 30 días? (exit code 1 = sí)
$ openssl s_client -connect cloudflare.com:443 -servername cloudflare.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000

# Probar contra un certificado expirado real
$ curl -sS https://expired.badssl.com

```
