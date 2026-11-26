#!/usr/bin/env bash
# Verificar la versión (debe ser 3.10 o superior)
python3 --version

# Crear y activar un entorno virtual aislado
python3 -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

# Actualizar pip y confirmar que usamos el Python del entorno
python -m pip install --upgrade pip
python -c "import sys; print(sys.executable)"

# Evitar subir el entorno al repo
echo ".venv/" >> .gitignore
