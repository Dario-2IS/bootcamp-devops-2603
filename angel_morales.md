Angel Morales

#redes sociales
https://www.linkedin.com/in/angel-yaiver-morales-rodr%C3%ADguez-8962269a/
https://www.instagram.com/in/angel-yaiver-morales-rodr%C3%ADguez-8962269a/

------------------------------------------------------------------------------------------------------------------

TAREA 2

1. Instalación Kiro -> Ok
2-3. Tabla de resultados comparativa de las 3 IA
   
| IA | Gemini | ChatGPT | Claude | Observación |
|---|---|---|---|---|
| **Precisión** | 8 | 6 | 10 | |
| **Claridad** | 7 | 7 | 10 | |
| **Comandos sugeridos** | `chmod +x`, `ls -l` | `chmod +x` | `ls -l`, `chmod +x` | Claude primero indica que validemos si tiene permisos. |
| **Tiempo de respuesta** | 5 segundos | 3 segundos | 2 segundos | |

4. cantidad de tokens validados con tiktoken desde mi cmd
   | Modelo | Prompt | Respuesta | Total |
|---|---:|---:|---:|
| Claude | 17 | 384 | 401 |
| Gemini | 17 | 407 | 424 |
| ChatGPT | 17 | 650 | 667 |

5. alucinación

En realidad, rsync no incluye ninguna opción nativa llamada --turbo-sync.

---------------------------------------------------------------------------------------------------------------------------------------------------------------


TAREA #4

1. script (https://gist.github.com/jthan24/de226afb3f84439ff122684ad047e469)
2. un script que lea una variable y la imprima por consola


root@ubuntu:~$ curl -O https://gist.githubusercontent.com/jthan24/de226afb3f84439ff122684ad047e469/raw/backup.sh
bash backup.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   543  100   543    0     0   2731      0 --:--:-- --:--:-- --:--:--  2742
CPU Load: 9.1%
Memory Usage: 21.22%
Disk Usage: 30%
Alert: One of the metrics is above 80%
root@ubuntu:~$ cat > variable.sh << 'EOF'
#!/bin/bash
NOMBRE="Angel"
echo "Hola, $NOMBRE"
EOF
root@ubuntu:~$ chmod +x variable.sh
./variable.sh
Hola, Angel

----------------------------------------------------------------------------------------

# Tarea 5


punto 1.

57316@LAPTOP-C5SG3VMP MINGW64 ~ (master)
$ for d in google.com github.com amazon.com bancodebogota.com.co; do
>   echo "=== $d ==="
>   curl -vI https://$d 2>&1 | grep -E "SSL connection|subject:|expire date|HTTP/"
> done
=== google.com ===
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
*  subject: CN=*.google.com
*  expire date: Jan 26 08:26:49 2027 GMT
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
> HEAD / HTTP/2
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0< HTTP/2 301
  0   220    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0HTTP/2 301
=== github.com ===
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256
*  subject: CN=github.com
*  expire date: Jan 27 23:59:59 2027 GMT
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
> HEAD / HTTP/2
< HTTP/2 200
< content-security-policy: default-src 'none'; base-uri 'self'; child-src github.githubassets.com github.com/assets-cdn/worker/ github.com/assets/ gist.github.com/assets-cdn/worker/; connect-src 'self' uploads.github.com www.githubstatus.com collector.github.com raw.githubusercontent.com api.github.com github-cloud.s3.amazonaws.com github-production-repository-file-5c1aeb.s3.amazonaws.com github-production-upload-manifest-file-7fdce7.s3.amazonaws.com github-production-user-asset-6210df.s3.amazonaws.com *.rel.tunnels.api.visualstudio.com wss://*.rel.tunnels.api.visualstudio.com github.githubassets.com objects-origin.githubusercontent.com copilot-proxy.githubusercontent.com proxy.individual.githubcopilot.com proxy.business.githubcopilot.com proxy.enterprise.githubcopilot.com *.actions.githubusercontent.com wss://*.actions.githubusercontent.com productionresultssa0.blob.core.windows.net productionresultssa1.blob.core.windows.net productionresultssa2.blob.core.windows.net productionresultssa3.blob.core.windows.net productionresultssa4.blob.core.windows.net productionresultssa5.blob.core.windows.net productionresultssa6.blob.core.windows.net productionresultssa7.blob.core.windows.net productionresultssa8.blob.core.windows.net productionresultssa9.blob.core.windows.net productionresultssa10.blob.core.windows.net productionresultssa11.blob.core.windows.net productionresultssa12.blob.core.windows.net productionresultssa13.blob.core.windows.net productionresultssa14.blob.core.windows.net productionresultssa15.blob.core.windows.net productionresultssa16.blob.core.windows.net productionresultssa17.blob.core.winHTTP/2 200
=== amazon.com ===
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
*  subject: CN=*.peg.a2z.com
*  expire date: Apr  5 23:59:59 2027 GMT
> HEAD / HTTP/1.1
< HTTP/1.1 301 Moved Permanently
  0   163    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0HTTP/1.1 301 Moved Permanently
=== bancodebogota.com.co ===
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256
*  expire date: Dec 22 16:56:02 2026 GMT
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
> HEAD / HTTP/2
< HTTP/2 301
  0   134    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0HTTP/2 301
Binary file (standard input) matches


Punto 2. 

57316@LAPTOP-C5SG3VMP MINGW64 ~ (master)
$ for d in google.com github.com amazon.com bancodebogota.com.co; do
>   echo "=== $d ==="
>   openssl s_client -connect $d:443 -servername $d </dev/null 2>/dev/null \
>     | openssl x509 -noout -subject -issuer -dates
> done
=== google.com ===
subject=CN = *.google.com
issuer=C = US, O = Google Trust Services, CN = WE2
notBefore=Nov  3 08:26:50 2026 GMT
notAfter=Jan 26 08:26:49 2027 GMT
=== github.com ===
subject=CN = github.com
issuer=C = GB, O = Sectigo Limited, CN = Sectigo Public Server Authentication CA DV E36
notBefore=Oct 30 00:00:00 2026 GMT
notAfter=Jan 27 23:59:59 2027 GMT
=== amazon.com ===
subject=CN = *.peg.a2z.com
issuer=C = US, O = DigiCert Inc, OU = www.digicert.com, CN = GeoTrust TLS RSA CA G1
notBefore=Sep 20 00:00:00 2026 GMT
notAfter=Apr  5 23:59:59 2027 GMT
=== bancodebogota.com.co ===
subject=C = CO, ST = "Bogot\C3\A1, D.C.", L = "Bogot\C3\A1, D.C.", O = BANCO DE BOGOTA S.A., CN = www.bancodebogota.com
issuer=C = BE, O = GlobalSign nv-sa, CN = GlobalSign RSA OV SSL CA 2018
notBefore=Nov 20 16:56:03 2025 GMT
notAfter=Dec 22 16:56:02 2026 GMT



Punto 3.

$ for d in google.com github.com amazon.com bancodebogota.com.co; do
  e>   echo "=== $d ==="
>   openssl s_client -connect $d:443 -servername $d </dev/null 2>/dev/null \
>     | openssl x509 -noout -checkend 2592000
>   echo "exit code: $?"
> done
=== google.com ===
Certificate will not expire
exit code: 0
=== github.com ===
Certificate will not expire
exit code: 0
=== amazon.com ===
Certificate will not expire
exit code: 0
=== bancodebogota.com.co ===
Certificate will not expire
exit code: 0



Punto 4.


57316@LAPTOP-C5SG3VMP MINGW64 ~ (master)
$ curl -sS https://expired.badssl.com

curl: (60) SSL certificate problem: certificate has expired
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
