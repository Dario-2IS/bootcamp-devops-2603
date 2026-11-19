# Terraform - Instancia EC2 en AWS

Este proyecto despliega una instancia EC2 en AWS usando Terraform, incluyendo un Security Group con acceso SSH y HTTP.

## Recursos que se crean

| Recurso | Descripción |
|---|---|
| `aws_instance` | Instancia EC2 con Amazon Linux 2023 |
| `aws_security_group` | Security Group con reglas de entrada SSH (22) y HTTP (80) |

## Requisitos previos

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) configurado
- Credenciales de AWS con permisos para crear instancias EC2 y Security Groups

### Configurar credenciales de AWS

```bash
aws configure
```

O mediante variables de entorno:

```bash
export AWS_ACCESS_KEY_ID="tu-access-key"
export AWS_SECRET_ACCESS_KEY="tu-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

## Estructura del proyecto

```
terraform-ec2/
├── main.tf           # Recursos principales (EC2, Security Group, AMI)
├── variables.tf      # Definición de variables
├── outputs.tf        # Valores de salida tras el despliegue
├── terraform.tfvars  # Valores de las variables
├── .gitignore        # Archivos excluidos de git
└── README.md         # Este archivo
```

## Variables

| Variable | Descripción | Tipo | Default |
|---|---|---|---|
| `aws_region` | Región de AWS | `string` | `us-east-1` |
| `instance_name` | Nombre de la instancia | `string` | `bootcamp-devops-ec2` |
| `instance_type` | Tipo de instancia | `string` | `t2.micro` |
| `environment` | Entorno (dev/staging/prod) | `string` | `dev` |
| `volume_size` | Tamaño del disco en GB | `number` | `8` |

## Uso

### 1. Inicializar Terraform

```bash
terraform init
```

### 2. Ver el plan de ejecución

```bash
terraform plan
```

### 3. Aplicar los cambios

```bash
terraform apply
```

Escribe `yes` cuando Terraform lo solicite para confirmar el despliegue.

### 4. Ver los outputs

```bash
terraform output
```

Ejemplo de salida:

```
ami_id               = "ami-0abcdef1234567890"
instance_id          = "i-0abcdef1234567890"
instance_public_dns  = "ec2-xx-xx-xx-xx.compute-1.amazonaws.com"
instance_public_ip   = "xx.xx.xx.xx"
security_group_id    = "sg-0abcdef1234567890"
```

### 5. Destruir los recursos

```bash
terraform destroy
```

## Personalización

Para cambiar algún valor, edita `terraform.tfvars`:

```hcl
aws_region    = "us-west-2"
instance_name = "mi-servidor"
instance_type = "t3.small"
environment   = "staging"
volume_size   = 20
```

## Notas

- La AMI se selecciona automáticamente: siempre usa la versión más reciente de Amazon Linux 2023.
- El volumen raíz usa `gp3` y está cifrado por defecto.
- La instancia cae dentro del [Free Tier de AWS](https://aws.amazon.com/free/) con `t2.micro` en regiones elegibles.

## Origen

Este proyecto fue generado por Kiro a partir del siguiente prompt:

> "Eres un experto en Terraform y AWS. Necesito que crees una carpeta con el nombre de AnaPaulaSantillan dentro de bootcamp-devops-2603, luego agrega un códido en terraform para una instancia de ec2. Así mismo, añade un README.md detallando la estructura, requisitos, y lo pertinente para levantar el proyecto."

**Est. Credits Used:** 0.54
