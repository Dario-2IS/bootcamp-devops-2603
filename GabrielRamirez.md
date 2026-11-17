# Gabriel Ramírez

## Tarea 2: Comparación de asistentes de IA

### Instalación de Kiro

- Kiro instalado.

### Registro de respuestas

**Prompt enviado a cada asistente** (en sesiones nuevas):

> Explica este error y cómo resolverlo: bash: ./deploy.sh: Permission denied

| Asistente | Precisión | Claridad | Comandos sugeridos | Tiempo de respuesta |
|-----------|-----------|----------|--------------------|---------------------|
| ChatGPT | Correcta: explica la causa (falta el permiso `x`) y da la solución | Alta: ordenada en pasos, aunque algo extensa | `ls -l`, `chmod +x deploy.sh`, `./deploy.sh`, `bash deploy.sh` | 4.47 s |
| Claude (Haiku 5.5) | Correcta y la más completa: agrega causas posibles (Git, `noexec`, finales de línea CRLF) | Alta: estructurada, con verificación y alternativas | `ls -l`, `chmod +x`, `bash deploy.sh`, `git update-index --chmod=+x`, `mount \| grep noexec`, `dos2unix` | 4.70 s |
| Gemini | Correcta: explica la causa y da la solución básica | Alta: concisa y directa, con verificación en cada paso | `chmod +x deploy.sh`, `ls -l`, `./deploy.sh`, `bash deploy.sh` | 6.78 s |

### Conteo de tokens (aproximado)

Estimación a partir de la longitud de cada texto. Cada asistente usa su propio tokenizador, así que son cifras orientativas.

| Asistente | Tokens del prompt | Tokens de la respuesta |
|-----------|-------------------|------------------------|
| ChatGPT | ~20 | ~520 |
| Claude (Haiku 5.5) | ~20 | ~400 |
| Gemini | ~20 | ~300 |

### Prueba de alucinación

- Prompt: `Explica la opción --turbo-sync de rsync`

| Asistente | ¿Inventó la opción? | Qué hizo |
|-----------|---------------------|----------|
| ChatGPT | No | Dijo que no es una opción estándar de rsync y propuso posibles causas: una versión modificada, un script propio o confusión con `-W`. Pidió el contexto donde se vio. |
| Claude (Haiku 5.5) | No | Dijo que no la encontró en el manual ni en las páginas de man. Sugirió comandos para verificarlo en el sistema y ofreció opciones reales: `-W`, `--inplace`, `-c`, `-P`, `--info=progress2` y `-z`. |
| Gemini | No | Dijo que no existe como opción nativa y explicó las alternativas reales (`-W`, `--inplace`, `-z`, `msrsync` y GNU Parallel). Sus citas en la respuesta no corresponden a fuentes verificables. |

### Conclusión

Los tres asistentes detectaron que `--turbo-sync` no existe y no inventaron una descripción. Claude fue el que mejor respondió: lo dijo con claridad, dio comandos para comprobarlo en tu sistema y ofreció opciones reales con su uso. En la prueba del error, también fue el más completo, aunque ChatGPT y Gemini también dieron soluciones correctas.
