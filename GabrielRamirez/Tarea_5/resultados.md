Resultados Tarea Nro 5

Ejecutados en WSL (Ubuntu) con los comandos de `tarea_5_Gabriel.md`.

```
name-gaen@TuFFer:/mnt/c/Users/gaenr$ curl -vI https://example.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519 / id-ecPublicKey
*  subject: CN=example.com
*  expire date: Dec 25 22:56:35 2026 GMT
* using HTTP/2
* [HTTP/2] [1] OPENED stream for https://example.com/
* [HTTP/2] [1] [:method: HEAD]
* [HTTP/2] [1] [:scheme: https]
* [HTTP/2] [1] [:authority: example.com]
* [HTTP/2] [1] [:path: /]
* [HTTP/2] [1] [user-agent: curl/8.5.0]
* [HTTP/2] [1] [accept: */*]
> HEAD / HTTP/2
< HTTP/2 200
HTTP/2 200
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect example.com:443 -servername example.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates
subject=CN = example.com
issuer=C = US, O = SSL Corporation, CN = Cloudflare TLS Issuing ECC CA 3
notBefore=Sep 26 22:49:11 2026 GMT
notAfter=Dec 25 22:56:35 2026 GMT
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect example.com:443 -servername example.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000; echo "exit $?"
Certificate will not expire
exit 0
name-gaen@TuFFer:/mnt/c/Users/gaenr$ curl -vI https://github.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256 / X25519 / id-ecPublicKey
*  subject: CN=github.com
*  expire date: Jan 27 23:59:59 2027 GMT
* using HTTP/2
* [HTTP/2] [1] OPENED stream for https://github.com/
* [HTTP/2] [1] [:method: HEAD]
* [HTTP/2] [1] [:scheme: https]
* [HTTP/2] [1] [:authority: github.com]
* [HTTP/2] [1] [:path: /]
* [HTTP/2] [1] [user-agent: curl/8.5.0]
* [HTTP/2] [1] [accept: */*]
> HEAD / HTTP/2
< HTTP/2 200
HTTP/2 200
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect github.com:443 -servername github.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates
subject=CN = github.com
issuer=C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV E36
notBefore=Oct 30 00:00:00 2026 GMT
notAfter=Jan 27 23:59:59 2027 GMT
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect github.com:443 -servername github.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000; echo "exit $?"
Certificate will not expire
exit 0
name-gaen@TuFFer:/mnt/c/Users/gaenr$ curl -vI https://google.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519 / id-ecPublicKey
*  subject: CN=*.google.com
*  expire date: Jan 26 08:26:49 2027 GMT
* using HTTP/2
* [HTTP/2] [1] OPENED stream for https://google.com/
* [HTTP/2] [1] [:method: HEAD]
* [HTTP/2] [1] [:scheme: https]
* [HTTP/2] [1] [:authority: google.com]
* [HTTP/2] [1] [:path: /]
* [HTTP/2] [1] [user-agent: curl/8.5.0]
* [HTTP/2] [1] [accept: */*]
> HEAD / HTTP/2
< HTTP/2 301
HTTP/2 301
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect google.com:443 -servername google.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates
subject=CN = *.google.com
issuer=C = US, O = Google Trust Services, CN = WE2
notBefore=Nov  3 08:26:50 2026 GMT
notAfter=Jan 26 08:26:49 2027 GMT
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect google.com:443 -servername google.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000; echo "exit $?"
Certificate will not expire
exit 0
name-gaen@TuFFer:/mnt/c/Users/gaenr$ curl -vI https://cloudflare.com 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384 / X25519 / id-ecPublicKey
*  subject: CN=cloudflare.com
*  expire date: Feb  1 23:47:08 2027 GMT
* using HTTP/2
* [HTTP/2] [1] OPENED stream for https://cloudflare.com/
* [HTTP/2] [1] [:method: HEAD]
* [HTTP/2] [1] [:scheme: https]
* [HTTP/2] [1] [:authority: cloudflare.com]
* [HTTP/2] [1] [:path: /]
* [HTTP/2] [1] [user-agent: curl/8.5.0]
* [HTTP/2] [1] [accept: */*]
> HEAD / HTTP/2
< HTTP/2 301
HTTP/2 301
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect cloudflare.com:443 -servername cloudflare.com </dev/null 2>/dev/null \
    | openssl x509 -noout -subject -issuer -dates
subject=CN = cloudflare.com
issuer=C = US, O = Google Trust Services, CN = WE1
notBefore=Nov  3 22:47:56 2026 GMT
notAfter=Feb  1 23:47:08 2027 GMT
name-gaen@TuFFer:/mnt/c/Users/gaenr$ openssl s_client -connect cloudflare.com:443 -servername cloudflare.com </dev/null 2>/dev/null \
    | openssl x509 -noout -checkend 2592000; echo "exit $?"
Certificate will not expire
exit 0
name-gaen@TuFFer:/mnt/c/Users/gaenr$ curl -sS https://expired.badssl.com; echo "exit $?"
curl: (60) SSL certificate problem: certificate has expired
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
exit 60
```
