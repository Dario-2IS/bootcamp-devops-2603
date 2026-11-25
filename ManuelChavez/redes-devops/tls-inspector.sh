#!/usr/bin/env bash
# =============================================================================
# tls-inspector.sh
# Inspects TLS/SSL certificates for a list of domains.
# Usage: ./tls-inspector.sh
# =============================================================================

DOMAINS=("example.com" "github.com" "google.com" "expired.badssl.com")

SEPARATOR="============================================================"
DAYS_AHEAD=30
SECONDS_AHEAD=$((DAYS_AHEAD * 24 * 3600))

for DOMAIN in "${DOMAINS[@]}"; do
  echo ""
  echo "$SEPARATOR"
  echo "  DOMAIN: $DOMAIN"
  echo "$SEPARATOR"

  # ------------------------------------------------------------------
  # 1. TLS handshake summary + HTTP status via curl
  # ------------------------------------------------------------------
  echo ""
  echo "[ 1 ] TLS handshake & HTTP status (curl)"
  echo "-------------------------------------------"
  curl -vI "https://$DOMAIN" 2>&1 | grep -E "SSL connection|subject:|expire date:|HTTP/"

  # ------------------------------------------------------------------
  # 2. Subject, issuer, and validity dates via openssl
  # ------------------------------------------------------------------
  echo ""
  echo "[ 2 ] Certificate subject, issuer, and dates (openssl)"
  echo "--------------------------------------------------------"
  openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates

  # ------------------------------------------------------------------
  # 3. Check if the certificate expires within the next 30 days
  # ------------------------------------------------------------------
  echo ""
  echo "[ 3 ] Expires within the next $DAYS_AHEAD days?"
  echo "---------------------------------------------------"
  openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend "$SECONDS_AHEAD"

  if [ $? -eq 0 ]; then
    echo "  → Certificate is VALID for at least $DAYS_AHEAD more days."
  else
    echo "  → WARNING: Certificate expires within $DAYS_AHEAD days (or is already expired)!"
  fi

  # ------------------------------------------------------------------
  # 4. Test curl against the domain (shows error on expired/invalid cert)
  # ------------------------------------------------------------------
  echo ""
  echo "[ 4 ] curl request result (strict TLS)"
  echo "----------------------------------------"
  RESPONSE=$(curl -sS "https://$DOMAIN" 2>&1)
  EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    echo "  → curl succeeded (TLS certificate is trusted and valid)."
  else
    echo "  → curl FAILED (exit code $EXIT_CODE):"
    echo "     $RESPONSE" | head -5
  fi

done

echo ""
echo "$SEPARATOR"
echo "  Inspection complete."
echo "$SEPARATOR"
echo ""
