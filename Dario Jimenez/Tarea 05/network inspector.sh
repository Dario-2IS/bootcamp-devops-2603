#!/bin/bash
# TLS/SSL certificate inspector for multiple domains

dominios=()

while (( ${#dominios[@]} < 3 )); do
    read -r -p "Ingrese un dominio (${#dominios[@]}/3, Enter para finalizar): " dominio

    [[ -z "$dominio" ]] && break

    if [[ ! "$dominio" =~ ^([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,63}$ ]]; then
        echo "Dominio no valido: $dominio"
        continue
    fi

    dominios+=("$dominio")
done

for dominio in "${dominios[@]}"; do
    echo
    echo "=== Analisis de $dominio ==="

    # Ver el handshake TLS y las fechas del certificado
    echo "--- Handshake TLS (curl) ---"
    curl -vI "https://$dominio" 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

    # Inspeccionar emisor y vigencia con openssl
    echo ""
    echo "--- Emisor y vigencia (openssl) ---"
    openssl s_client -connect "$dominio":443 -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -subject -issuer -dates

    # ¿Expira en los próximos 30 días? (exit code 1 = sí)
    echo ""
    echo "--- ¿Expira en los próximos 30 días? ---"
    openssl s_client -connect "$dominio":443 -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -checkend 2592000
done

# Probar contra un certificado expirado real
if (( ${#dominios[@]} > 0 )); then
    echo
    echo "=== Prueba con certificado expirado ==="
    curl -sS https://expired.badssl.com
fi
