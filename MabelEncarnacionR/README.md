# Terraform EC2 en AWS — TAREA-03

Provisión de una instancia EC2 en AWS usando Terraform (IaC).

## Requisitos previos

1. **Terraform** >= 1.5 instalado (`terraform -v`).
2. **AWS CLI** configurado con credenciales válidas:
   ```bash
   aws configure
   # Pide: AWS Access Key ID, Secret Access Key, región (us-east-1), formato (json)
   ```
3. **Llave SSH** local para acceder a la instancia:
   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/mabel-ec2-key
   # Deja la passphrase vacía o ponle una. Genera mabel-ec2-key y mabel-ec2-key.pub
   ```

## Uso

1. Copia el archivo de variables de ejemplo y edítalo:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
2. Abre `terraform.tfvars` y pega en `public_key` el contenido completo de
   `~/.ssh/mabel-ec2-key.pub` (una sola línea).
3. Inicializa Terraform (descarga el provider de AWS):
   ```bash
   terraform init
   ```
4. Previsualiza lo que se va a crear:
   ```bash
   terraform plan
   ```
5. Crea la infraestructura:
   ```bash
   terraform apply
   # escribe "yes" cuando lo pida
   ```
6. Al terminar, Terraform imprime la IP pública y el comando `ssh` para conectarte:
   ```bash
   ssh -i ~/.ssh/mabel-ec2-key ec2-user@<public_dns>
   ```

## Destruir (para no generar costos)

Cuando termines de probar, destruye todo para evitar cobros en AWS:
```bash
terraform destroy
# escribe "yes"
```

## Seguridad

- La regla de SSH permite por defecto conexiones desde `0.0.0.0/0` (todo
  Internet). Restringe `ssh_cidr` en `terraform.tfvars` a tu IP para mayor
  seguridad (ej. `"200.10.10.5/32"`).
- La llave privada NUNCA se sube al repositorio (ignorada en `.gitignore`).
- No hay secretos en el código: las credenciales de AWS se toman del entorno
  (`aws configure` / variables de entorno).
