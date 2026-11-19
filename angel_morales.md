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

-------------------------------------------------------------------------------------------------------------------------------------


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