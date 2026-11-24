# Tarea 5: Certificados TLS

**Autor:** Gabriel Ramírez

## Proceso

1. Se inspeccionó el certificado TLS de `example.com` con `curl` y `openssl`: handshake, sujeto, emisor, fechas de vigencia y si expira en los próximos 30 días.
2. Se repitió el mismo bloque de comandos para tres dominios adicionales: `github.com`, `google.com` y `cloudflare.com`.
3. Se probó la conexión contra un certificado expirado real con `expired.badssl.com`.
4. Los comandos se ejecutaron en WSL y están en `tarea_5_Gabriel.md`. Las salidas están en `resultados.md`.

## Resultados

- `example.com`, `github.com`, `google.com` y `cloudflare.com` tienen certificados vigentes por más de 30 días.
- `expired.badssl.com` rechaza la conexión por certificado expirado (código de salida 60).
