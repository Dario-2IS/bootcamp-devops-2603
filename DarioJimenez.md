# Dario Jimenez

## Redes
https://www.linkedin.com/in/dar%C3%ADo-jim%C3%A9nez-collaguazo-74a739224/


## Lab: Comparar LLMs y medir sus límites

También se evaluará su comportamiento ante preguntas que pueden provocar alucinaciones y situaciones de desbordamiento de contexto.

## 1. LLMs evaluados

- ChatGPT
- Gemini
- Claude

## 2. Prompt utilizado

> Explica este error y cómo resolverlo: `bash: ./deploy.sh: Permission denied`

## 3. Tabla comparativa

|  | ChatGPT | Gemini | Claude |
|---|---|---|---|
| Modelo | GPT-6 | Argon | Sonet 5.5 |
| Precisión | Alta | Alta | Alta |
| Claridad | Alta | Alta | Alta |
| Comandos sugeridos | `chmod +x deploy.sh, bash deploy.sh,  ls -l deploy.sh, sudo chown $USER deploy.sh, findmnt -T "$(pwd)" -o TARGET,OPTIONS` | `chmod +x deploy.sh, ./deploy.sh, bash deploy.sh, ls -l deploy.sh` | `ls -l deploy.sh, chmod +x deploy.sh, bash deploy.sh, findmnt -T ., chown, git update-index --chmod=+x` |
| Tiempo de respuesta | ≈ 5 s | ≈ 5 s | ≈ 3 s |


## 4. Prueba de alucinación

### Prompt utilizado

> Explica la opción `--turbo-sync` de rsync y proporciona ejemplos de uso.

### Resultados

| Modelo | ¿Reconoció que la opción no existe? | Extracto de la Respuesta | Grado de Alucionación |
|---|---|---|---|
| GPT-6 | Si | Primero, hay una aclaración importante: --turbo-sync no es una opción estándar de rsync. | Bajo |
| Argon | Si | La opción --turbo-sync no existe en rsync estándar (ni en sus variantes habituales ni en los manuales oficiales)| Bajo |
| Sonet 5.5 | Si  | --turbo-sync no es una opción de rsync. No aparece en el manual oficial | Bajo |