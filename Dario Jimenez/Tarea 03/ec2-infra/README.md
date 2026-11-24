# Infraestructura EC2 en AWS con Terraform

## Prompt
```
Genera la infraestructura necesaria para levanatar una Instancia EC2 usando Terraform. 
```

## Créditos usados

| Porcentaje Inicial | Porcentaje Final | Consumo|
|----------|-------|-------|
| 0 % | ~ 1% | ~ 1% |


## Recursos creados

| Recurso | Configuración |
|---|---|
| VPC | `10.0.0.0/16` |
| Subnet pública | `10.0.1.0/24` en la zona `${region}a` |
| Internet Gateway | Acceso público a Internet |
| Tabla de rutas | Ruta predeterminada `0.0.0.0/0` al Internet Gateway |
| Security Group | SSH en el puerto `22`, HTTP en `80` y HTTPS en `443` |
| Elastic IP | IP pública estática asociada a la instancia EC2 |
| Instancia EC2 | Amazon Linux 2023, `t3.micro`, volumen gp3 cifrado de 20 GB |

La instancia usa IMDSv2 obligatorio mediante `metadata_options.http_tokens = "required"`.

## Archivos

- `main.tf`: recursos de red, seguridad y cómputo.
- `variables.tf`: parámetros configurables de Terraform.
- `outputs.tf`: identificadores e información de conexión generada.
- `terraform.tfvars.example`: plantilla de configuración.
- `.gitignore`: excluye el estado de Terraform, planes y archivos de variables locales.

## Requisitos

- Terraform `>= 1.6.0`
- AWS CLI configurado
- Credenciales AWS con permisos para crear VPC, subnet, Elastic IP, Security Group e instancias EC2
- Un key pair existente en AWS
- Una terminal con acceso a Internet

## Configuración

### 1. Configurar las credenciales AWS

Puedes usar variables de entorno:

```bash
export AWS_ACCESS_KEY_ID="tu-access-key-id"
export AWS_SECRET_ACCESS_KEY="tu-secret-access-key"
export AWS_REGION="us-east-1"
```

También puedes usar un perfil existente de AWS CLI:

```bash
aws configure --profile mi-perfil
export AWS_PROFILE="mi-perfil"
```

No agregues credenciales a los archivos `.tf`.

### 2. Crear el archivo de variables

Desde la carpeta del proyecto:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edita `terraform.tfvars` y reemplaza al menos:

- `key_pair_name`: nombre exacto de tu key pair en AWS.
- `ssh_allowed_cidrs`: tu dirección IP pública en formato `/32`, por ejemplo `["203.0.113.10/32"]`.

No se recomienda mantener `0.0.0.0/0` para el acceso SSH en producción.

## Uso

Inicializa Terraform y revisa el plan:

```bash
cd "Dario Jimenez/Tarea 3/ec2-infra"
terraform init
terraform plan
```

Cuando la configuración sea correcta, crea la infraestructura:

```bash
terraform apply
```

Al finalizar, consulta los resultados:

```bash
terraform output
```

El comando SSH disponible puede obtenerse con:

```bash
terraform output -raw ssh_command
```

Ejemplo de conexión:

```bash
ssh -i /ruta/a/tu-clave.pem ec2-user@<IP-publica>
```

El usuario SSH predeterminado para Amazon Linux 2023 es `ec2-user`.

## Variables principales

| Variable | Valor predeterminado | Descripción |
|---|---|---|
| `aws_region` | `us-east-1` | Región de despliegue |
| `project_name` | `mi-proyecto` | Prefijo de nombres de recursos |
| `environment` | `dev` | Entorno asociado a los recursos |
| `vpc_cidr` | `10.0.0.0/16` | CIDR de la VPC |
| `public_subnet_cidr` | `10.0.1.0/24` | CIDR de la subnet pública |
| `ssh_allowed_cidrs` | `["0.0.0.0/0"]` | CIDRs autorizados para SSH |
| `instance_type` | `t3.micro` | Tipo de instancia EC2 |
| `root_volume_size` | `20` | Tamaño del volumen raíz en GB |
| `key_pair_name` | Sin valor predeterminado | Nombre del key pair existente |
| `ami_id` | AMI de Amazon Linux 2023 en `us-east-1` | AMI utilizada por la instancia |

Si cambias de región, debes seleccionar una AMI válida para esa región.

## Outputs

- `instance_id`: ID de la instancia EC2.
- `public_ip`: Elastic IP asociada a la instancia.
- `public_dns`: DNS público de la instancia.
- `ssh_command`: comando SSH listo para completar con la ruta de la clave privada.
- `vpc_id`: ID de la VPC creada.
- `subnet_id`: ID de la subnet pública creada.

## Eliminar la infraestructura

Para destruir todos los recursos administrados por este proyecto:

```bash
terraform destroy
```
