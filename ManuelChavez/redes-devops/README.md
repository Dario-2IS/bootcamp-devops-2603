# redes-devops — TLS Certificate Inspector

## What this is

`tls-inspector.sh` is a Bash script that checks the TLS/SSL certificate health of a list of domains. It is useful for validating that certificates are valid, trusted, and not about to expire — a common DevOps task when managing web services, pipelines, or APIs that depend on secure connections.

---

## Script: `tls-inspector.sh`

### How it works

The script loops over an array of domains and runs four checks against each one.

```bash
DOMAINS=("example.com" "github.com" "google.com" "expired.badssl.com")
```

---

### Check 1 — TLS handshake summary and HTTP status (`curl`)

```bash
curl -vI "https://$DOMAIN" 2>&1 | grep -E "SSL connection|subject:|expire date:|HTTP/"
```

| Flag / option | Purpose |
|---|---|
| `-v` | Verbose mode — prints the full TLS handshake details |
| `-I` | Sends a HEAD request instead of GET (faster, no body) |
| `2>&1` | Merges stderr (where curl writes TLS info) into stdout so grep can read it |
| `grep -E ...` | Filters only the lines we care about: TLS version, certificate subject, expiry date, and the HTTP status code |

**What you learn:** Which TLS version and cipher suite was negotiated, what domain the certificate belongs to, when it expires, and whether the server responded successfully.

---

### Check 2 — Subject, issuer, and validity dates (`openssl`)

```bash
openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" </dev/null 2>/dev/null \
  | openssl x509 -noout -subject -issuer -dates
```

| Flag / option | Purpose |
|---|---|
| `s_client` | Opens a raw TLS connection to the server |
| `-connect domain:443` | Target host and port |
| `-servername` | Sends the SNI (Server Name Indication) header — required for servers that host multiple certificates |
| `</dev/null` | Closes stdin immediately so the command doesn't hang waiting for input |
| `2>/dev/null` | Suppresses the verbose handshake output |
| `openssl x509 -noout` | Parses the certificate without printing the raw PEM |
| `-subject` | Prints the domain the certificate was issued to |
| `-issuer` | Prints the Certificate Authority (CA) that signed it |
| `-dates` | Prints `notBefore` and `notAfter` timestamps |

**What you learn:** The full certificate chain details — who issued the cert and the exact validity window.

---

### Check 3 — Expiry within 30 days (`openssl -checkend`)

```bash
openssl s_client -connect "$DOMAIN:443" -servername "$DOMAIN" </dev/null 2>/dev/null \
  | openssl x509 -noout -checkend 2592000
```

| Value | Meaning |
|---|---|
| `2592000` | Seconds in 30 days (30 × 24 × 3600) |
| Exit code `0` | Certificate is still valid beyond that window |
| Exit code `1` | Certificate expires within 30 days, or has already expired |

The script wraps this with an `if` block to print a human-readable verdict instead of relying on exit codes alone.

**What you learn:** Whether you need to renew the certificate soon. This check is what you'd put in a cron job or CI pipeline alert.

---

### Check 4 — curl strict TLS request

```bash
curl -sS "https://$DOMAIN"
```

| Flag | Purpose |
|---|---|
| `-s` | Silent mode — suppresses the progress bar |
| `-S` | Still shows error messages even in silent mode |

This simulates what a real browser or API client experiences. If the certificate is expired, self-signed, or untrusted, curl refuses the connection and returns a non-zero exit code. The script captures the exit code and prints the error message.

**What you learn:** Whether the certificate would be rejected by any standard HTTP client — the real-world impact of a certificate problem.

---

## Output for 3 domains

> `example.com` is included as the reference domain from the original exercise. The 3 additional domains are `github.com`, `google.com`, and `expired.badssl.com`.

---

### `example.com`

```
[ 1 ] TLS handshake & HTTP status (curl)
* SSL connection using TLSv1.3 / AEAD-CHACHA20-POLY1305-SHA256 / [blank] / UNDEF
*  subject: CN=example.com
*  expire date: Feb 22 23:53:08 2027 GMT
HTTP/2 200

[ 2 ] Certificate subject, issuer, and dates (openssl)
subject= /CN=example.com
issuer= /C=US/O=SSL Corporation/CN=Cloudflare TLS Issuing ECC CA 3
notBefore=Nov 24 23:48:34 2026 GMT
notAfter=Feb 22 23:53:08 2027 GMT

[ 3 ] Expires within the next 30 days?
  → Certificate is VALID for at least 30 more days.

[ 4 ] curl request result (strict TLS)
  → curl succeeded (TLS certificate is trusted and valid).
```

**Summary:** Valid certificate issued by Cloudflare's CA, using TLS 1.3. Expires February 2027.

---

### `github.com`

```
[ 1 ] TLS handshake & HTTP status (curl)
* SSL connection using TLSv1.3 / AEAD-CHACHA20-POLY1305-SHA256 / [blank] / UNDEF
*  subject: CN=github.com
*  expire date: Jan 27 23:59:59 2027 GMT
HTTP/2 200

[ 2 ] Certificate subject, issuer, and dates (openssl)
subject= /CN=github.com
issuer= /C=GB/O=Sectigo Limited/CN=Sectigo Public Server Authentication CA DV E36
notBefore=Oct 30 00:00:00 2026 GMT
notAfter=Jan 27 23:59:59 2027 GMT

[ 3 ] Expires within the next 30 days?
  → Certificate is VALID for at least 30 more days.

[ 4 ] curl request result (strict TLS)
  → curl succeeded (TLS certificate is trusted and valid).
```

**Summary:** Valid certificate issued by Sectigo (a commercial CA), using TLS 1.3. Expires January 2027.

---

### `google.com`

```
[ 1 ] TLS handshake & HTTP status (curl)
* SSL connection using TLSv1.3 / AEAD-CHACHA20-POLY1305-SHA256 / [blank] / UNDEF
*  subject: CN=*.google.com
*  expire date: Jan 26 08:26:49 2027 GMT
HTTP/2 301

[ 2 ] Certificate subject, issuer, and dates (openssl)
subject= /CN=*.google.com
issuer= /C=US/O=Google Trust Services/CN=WE2
notBefore=Nov  3 08:26:50 2026 GMT
notAfter=Jan 26 08:26:49 2027 GMT

[ 3 ] Expires within the next 30 days?
  → Certificate is VALID for at least 30 more days.

[ 4 ] curl request result (strict TLS)
  → curl succeeded (TLS certificate is trusted and valid).
```

**Summary:** Wildcard certificate (`*.google.com`) issued by Google's own CA (Google Trust Services). The HTTP 301 redirect is expected — `google.com` redirects to `www.google.com`. Certificate is healthy.

---

### `expired.badssl.com` ⚠️

```
[ 1 ] TLS handshake & HTTP status (curl)
(no output — curl refused the connection before the handshake completed)

[ 2 ] Certificate subject, issuer, and dates (openssl)
subject= /OU=Domain Control Validated/OU=PositiveSSL Wildcard/CN=*.badssl.com
issuer= /C=GB/ST=Greater Manchester/L=Salford/O=COMODO CA Limited/CN=COMODO RSA Domain Validation Secure Server CA
notBefore=Apr  9 00:00:00 2015 GMT
notAfter=Apr 12 23:59:59 2015 GMT

[ 3 ] Expires within the next 30 days?
  → WARNING: Certificate expires within 30 days (or is already expired)!

[ 4 ] curl request result (strict TLS)
  → curl FAILED (exit code 60):
     curl: (60) SSL certificate problem: certificate has expired
```

**Summary:** This is an intentionally expired certificate (expired April 2015, nearly 10 years ago), hosted by [badssl.com](https://badssl.com) for testing purposes. `openssl s_client` can still read and display the certificate data even when it's expired, while `curl` rejects the connection entirely — exactly what any real browser or HTTP client would do. This is the expected behavior and demonstrates why certificate expiry monitoring matters.

---

## Key concepts

| Term | Meaning |
|---|---|
| **TLS** | Transport Layer Security — the protocol that encrypts HTTPS traffic |
| **Certificate** | A digital document that proves a server's identity, signed by a CA |
| **CA (Certificate Authority)** | A trusted organization that issues and signs certificates (e.g. Let's Encrypt, Sectigo, Google) |
| **SNI** | Server Name Indication — tells the server which certificate to present when multiple domains share an IP |
| **notBefore / notAfter** | The validity window of a certificate |
| **`checkend`** | An openssl option to test if a cert expires within N seconds from now |
| **Exit code 60** | curl's error code for an SSL certificate problem (expired, untrusted, mismatched domain) |
