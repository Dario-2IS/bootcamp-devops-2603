# Despliegue EC2 con Terraform — Amazon Linux 2023

## Descripción

Configuración de Terraform para desplegar una instancia EC2 `t3.micro` con la AMI más reciente de Amazon Linux 2023 en la región `us-east-1`, acompañada de un Security Group con acceso SSH y salida total a internet.

---

## Prompt original

> Crea en este directorio actual los archivos de Terraform (providers.tf, variables.tf, main.tf y outputs.tf) para desplegar una instancia EC2 t3.micro utilizando la AMI más reciente de Amazon Linux 2023 en la región us-east-1, junto con un Security Group que permita tráfico SSH (puerto 22) y salida total a internet. Además, genera un archivo README.md en este mismo directorio que documente la estructura de los archivos creados, incluya textualmente este prompt que te acabo de enviar y deje una sección titulada "Consumo de Créditos" para anotar los créditos gastados.

---

## Estructura de archivos

```
guillermo/
├── providers.tf   # Versión de Terraform requerida y configuración del provider AWS
├── variables.tf   # Variables parametrizables (región, tipo de instancia, CIDR SSH, etc.)
├── main.tf        # Data source para la AMI, Security Group e instancia EC2
├── outputs.tf     # Valores exportados tras el apply (IDs, IP pública, DNS)
└── README.md      # Este archivo
```

### `providers.tf`
Declara el bloque `terraform` con la versión mínima requerida (`>= 1.6.0`) y el provider `hashicorp/aws` en su rama `~> 5.0`. También configura el provider con la región definida en `var.aws_region`.

### `variables.tf`
Define cinco variables:

| Variable | Tipo | Default | Descripción |
|---|---|---|---|
| `aws_region` | string | `us-east-1` | Región de despliegue |
| `instance_type` | string | `t3.micro` | Tipo de instancia EC2 |
| `instance_name` | string | `bootcamp-ec2` | Etiqueta `Name` de la instancia |
| `sg_name` | string | `bootcamp-sg` | Nombre del Security Group |
| `allowed_ssh_cidr` | string | `0.0.0.0/0` | CIDR permitido para SSH |

### `main.tf`
Contiene tres bloques:

1. **`data "aws_ami"`** — Consulta la AMI más reciente de Amazon Linux 2023 (`al2023-ami-*-x86_64`) publicada por Amazon, con arquitectura `x86_64`, virtualización `hvm` y estado `available`.
2. **`resource "aws_security_group"`** — Crea un SG con una regla `ingress` para el puerto 22/TCP y una regla `egress` abierta (`0.0.0.0/0`, todos los puertos).
3. **`resource "aws_instance"`** — Lanza la instancia EC2 usando el ID de AMI obtenido dinámicamente y el SG creado.

### `outputs.tf`
Expone tras el `terraform apply`:

- `instance_id` — ID de la instancia EC2.
- `instance_public_ip` — IP pública asignada.
- `instance_public_dns` — Nombre DNS público.
- `ami_id` — ID de la AMI de Amazon Linux 2023 seleccionada.
- `security_group_id` — ID del Security Group.

---

## Uso

```bash
# 1. Inicializar el directorio de trabajo
terraform init

# 2. Revisar el plan de ejecución
terraform plan

# 3. Aplicar la configuración
terraform apply

# 4. Destruir los recursos cuando ya no se necesiten
terraform destroy
```

> **Nota de seguridad:** el valor por defecto de `allowed_ssh_cidr` es `0.0.0.0/0`. En entornos no efímeros, restríngelo a tu IP pública:
> ```bash
> terraform apply -var="allowed_ssh_cidr=<TU_IP>/32"
> ```

---

## Requisitos previos

- Terraform `>= 1.6.0`
- AWS CLI configurado (`aws configure`) o variables de entorno `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` con permisos sobre EC2 y VPC.

---

## Consumo de Créditos

## Consumo de Créditos

| Fecha | Concepto | Créditos gastados |
|---|---|---|
| 2026-11-16 | Generación de infraestructura EC2 en Terraform (`providers.tf`, `variables.tf`, `main.tf`, `outputs.tf`) y documentación (`README.md`) con Kiro CLI (Plan Kiro Free) | `0.45` créditos (`0.9%` del plan mensual de 50 créditos) |
