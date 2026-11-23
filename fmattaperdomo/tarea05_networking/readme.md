# Tarea 05 - Networking: Inspector de certificados TLS/SSL

## Descripción

El script [inspector.sh](./inspector.sh) inspecciona los certificados TLS/SSL de **tres dominios válidos** (`google.com`, `github.com` y `wikipedia.org`) y muestra para cada uno la misma información:

1. **Handshake TLS con `curl`**: versión del protocolo TLS, subject del certificado, fecha de expiración y código de respuesta HTTP.
2. **Emisor y vigencia con `openssl`**: subject (a quién pertenece), issuer (autoridad certificadora que lo emitió) y fechas de vigencia (`notBefore` / `notAfter`).
3. **Chequeo de expiración a 30 días**: con `openssl x509 -checkend 2592000` (2.592.000 segundos = 30 días). Si el exit code es `1`, el certificado expira pronto y se muestra una **ALERTA**; si es `0`, se muestra **OK**.

## Cómo funciona

```bash
DOMINIOS=("google.com" "github.com" "wikipedia.org")

for dominio in "${DOMINIOS[@]}"; do
    # 1. Handshake TLS y fechas del certificado
    curl -vI "https://$dominio" 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

    # 2. Emisor y vigencia
    openssl s_client -connect "$dominio:443" -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -subject -issuer -dates

    # 3. ¿Expira en los próximos 30 días? (exit code 1 = sí)
    openssl s_client -connect "$dominio:443" -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -checkend 2592000
done
```

- El array `DOMINIOS` permite agregar o cambiar dominios fácilmente.
- `-servername` habilita SNI (Server Name Indication) para obtener el certificado correcto cuando varios dominios comparten la misma IP.
- `</dev/null` cierra la entrada estándar para que `openssl s_client` no quede esperando.

## Ejecución

```bash
chmod +x inspector.sh
./inspector.sh
```

## Resultados de la ejecución

```text
============================================================
 Dominio: google.com
============================================================
--- Handshake TLS (curl) ---
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519MLKEM768 / id-ecPublicKey
*   subject: CN=*.google.com
*   expire date: Jan 26 08:26:49 2027 GMT
* using HTTP/2
< HTTP/2 301

--- Emisor y vigencia (openssl) ---
subject=CN=*.google.com
issuer=C=US, O=Google Trust Services, CN=WE2
notBefore=Nov  3 08:26:50 2026 GMT
notAfter=Jan 26 08:26:49 2027 GMT

--- ¿Expira en los próximos 30 días? ---
Certificate will not expire
OK: el certificado NO expira en los próximos 30 días

============================================================
 Dominio: github.com
============================================================
--- Handshake TLS (curl) ---
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256 / x25519 / id-ecPublicKey
*   subject: CN=github.com
*   expire date: Jan 27 23:59:59 2027 GMT
* using HTTP/2
< HTTP/2 200

--- Emisor y vigencia (openssl) ---
subject=CN=github.com
issuer=C=GB, O=Sectigo Limited, CN=Sectigo Public Server Authentication CA DV E36
notBefore=Oct 30 00:00:00 2026 GMT
notAfter=Jan 27 23:59:59 2027 GMT

--- ¿Expira en los próximos 30 días? ---
Certificate will not expire
OK: el certificado NO expira en los próximos 30 días

============================================================
 Dominio: wikipedia.org
============================================================
--- Handshake TLS (curl) ---
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256 / x25519 / id-ecPublicKey
*   subject: CN=*.wikipedia.org
*   expire date: Jan  2 18:34:50 2027 GMT
* using HTTP/2
< HTTP/2 301

--- Emisor y vigencia (openssl) ---
subject=CN=*.wikipedia.org
issuer=C=US, O=Let's Encrypt, CN=YE2
notBefore=Oct  4 18:34:51 2026 GMT
notAfter=Jan  2 18:34:50 2027 GMT

--- ¿Expira en los próximos 30 días? ---
Certificate will not expire
OK: el certificado NO expira en los próximos 30 días
```

## Análisis de los resultados

| Dominio | Subject | Emisor (CA) | Vigencia | ¿Expira en 30 días? |
|---|---|---|---|---|
| google.com | `CN=*.google.com` (wildcard) | Google Trust Services (WE2) | 3-nov-2026 → 26-ene-2027 | No ✅ |
| github.com | `CN=github.com` | Sectigo Limited (DV E36) | 30-oct-2026 → 27-ene-2027 | No ✅ |
| wikipedia.org | `CN=*.wikipedia.org` (wildcard) | Let's Encrypt (YE2) | 4-oct-2026 → 2-ene-2027 | No ✅ |

Observaciones:

- Los tres dominios negocian **TLSv1.3**, la versión más reciente y segura del protocolo.
- Google y Wikipedia usan certificados **wildcard** (`*.dominio`) que cubren todos sus subdominios; GitHub usa un certificado específico para `github.com`.
- Cada sitio usa una **autoridad certificadora distinta**: Google su propia CA (Google Trust Services), GitHub una comercial (Sectigo) y Wikipedia una gratuita (Let's Encrypt).
- Los certificados modernos tienen **vigencias cortas** (~90 días en estos casos), lo que obliga a renovarlos automáticamente y reduce el riesgo si una clave se compromete.
- `google.com` y `wikipedia.org` responden `HTTP/2 301` porque redirigen a `www.google.com` y `www.wikipedia.org`; `github.com` responde `200` directamente.
