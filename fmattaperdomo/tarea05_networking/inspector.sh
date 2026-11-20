#!/bin/bash
# Inspector de certificados TLS/SSL para varios dominios

DOMINIOS=("google.com" "github.com" "wikipedia.org")

for dominio in "${DOMINIOS[@]}"; do
    echo "============================================================"
    echo " Dominio: $dominio"
    echo "============================================================"

    # Ver el handshake TLS y las fechas del certificado
    echo "--- Handshake TLS (curl) ---"
    curl -vI "https://$dominio" 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"

    # Inspeccionar emisor y vigencia con openssl
    echo ""
    echo "--- Emisor y vigencia (openssl) ---"
    openssl s_client -connect "$dominio:443" -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -subject -issuer -dates

    # ¿Expira en los próximos 30 días? (exit code 1 = sí)
    echo ""
    echo "--- ¿Expira en los próximos 30 días? ---"
    if openssl s_client -connect "$dominio:443" -servername "$dominio" </dev/null 2>/dev/null \
        | openssl x509 -noout -checkend 2592000; then
        echo "OK: el certificado NO expira en los próximos 30 días"
    else
        echo "ALERTA: el certificado expira en menos de 30 días"
    fi

    echo ""
done
