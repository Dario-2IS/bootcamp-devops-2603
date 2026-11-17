# Prompt: desplegar una instancia EC2 con Terraform

```text
Actúa como especialista en Terraform y AWS.

Estoy trabajando en el directorio
~/bootcamp-devops-2603/fmattaperdomo-infra-code. Revisa primero su contenido
existente y, basándote en él, crea la configuración mínima y completa de
Terraform para desplegar una instancia EC2 en AWS.

Requisitos:
- Incluye los archivos necesarios para definir Terraform, el proveedor AWS y
  la región.
- Define las variables necesarias para configurar la instancia.
- Incluye la configuración de la instancia EC2 y los recursos de red o
  seguridad que requiera.
- Añade outputs útiles para consultar los datos de la instancia desplegada.
- Evita duplicar o reemplazar innecesariamente la configuración existente.
- Documenta los comandos para inicializar, revisar y aplicar la configuración,
  junto con los valores que debo comprobar antes del despliegue.

Formato de la respuesta:
- Usa Markdown con títulos y secciones breves y fáciles de recorrer.
- Presenta los archivos creados o modificados en una tabla con su propósito.
- Muestra los comandos en bloques de código e incluye una lista de
  verificaciones previas al despliegue.
- Destaca claramente cualquier requisito o precaución importante.

Al finalizar, resume los archivos creados o modificados y explica brevemente
el propósito de cada uno.
```

---

## Estimación de tokens

Conteo del texto del prompt y los archivos generados con `o200k_base`
(referencia para GitHub Copilot; no es una medición oficial del consumo real).

| Categoría | Alcance contado | Tokens |
|---|---|---:|
| Entrada | Texto del prompt, sin incluir el formato Markdown que lo rodea. | 279 |
| Salida en Terraform | Contenido de `provider.tf`, `variables.tf`, `main.tf` y `outputs.tf`. | 869 |
| Respuesta en este README | Documentación de la configuración, sin el prompt ni esta sección. | 998 |
| **Salida total** | Archivos Terraform y respuesta documentada. | **1.867** |

El conteo no incluye instrucciones del sistema, historial de conversación,
metadatos ni llamadas a herramientas; el consumo real puede variar según el
modelo utilizado.


# Respuesta: Terraform – EC2 en AWS

Configuración mínima y completa para desplegar una instancia EC2 en AWS,
incluyendo proveedor, variables con validación, red/seguridad y outputs.

---

## Archivos del proyecto

| Archivo | Estado | Propósito |
|---|---|---|
| `provider.tf` | Existente | Declara Terraform ≥ 1.3 y el proveedor AWS `~> 5.0` con la región configurable. |
| `variables.tf` | Modificado | Variables de entrada con validaciones: región, tipo de instancia, AMI, nombre, key pair y CIDR de SSH. |
| `main.tf` | Modificado | Security Group (SSH restringido por CIDR + egreso total) e instancia EC2. |
| `outputs.tf` | Existente | Expone `instance_id`, `public_ip`, `public_dns` y `security_group_id`. |

---

## Variables disponibles

| Variable | Valor por defecto | Descripción |
|---|---|---|
| `aws_region` | `us-east-1` | Región de AWS donde se despliega. |
| `instance_type` | `t2.micro` | Tipo de instancia EC2. |
| `ami_id` | `ami-0c02fb55956c7d316` | AMI de Amazon Linux 2023 (válida en `us-east-1`). |
| `instance_name` | `fmattaperdomo-ec2` | Valor del tag `Name` en la instancia y el SG. |
| `key_name` | `""` (ninguna) | Nombre del key pair existente para acceso SSH. Vacío = sin clave. |
| `ssh_allowed_cidr` | `0.0.0.0/0` | CIDR con acceso al puerto 22. **Restringir en producción.** |

---

## Comandos de despliegue

```bash
# 1. Situarse en el directorio del proyecto
cd ~/bootcamp-devops-2603/fmattaperdomo-infra-code

# 2. Inicializar: descarga el proveedor AWS
terraform init

# 3. Revisar el plan de cambios antes de aplicar
terraform plan

# 4. Aplicar la configuración
terraform apply
```

Para sobreescribir variables sin editar archivos:

```bash
terraform apply \
  -var="key_name=mi-llave" \
  -var="ssh_allowed_cidr=203.0.113.10/32" \
  -var="instance_type=t3.micro"
```

---

## ✅ Verificaciones previas al despliegue

- [ ] **Credenciales AWS** configuradas vía `~/.aws/credentials`,
      variables de entorno (`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`) o rol IAM.
- [ ] **AMI válida en la región**: `ami-0c02fb55956c7d316` es Amazon Linux 2023 en
      `us-east-1`. Para otra región, busca el AMI correcto:
      ```bash
      aws ec2 describe-images \
        --owners amazon \
        --filters "Name=name,Values=al2023-ami-*-x86_64" \
        --query "sort_by(Images,&CreationDate)[-1].ImageId" \
        --region <tu-región>
      ```
- [ ] **Key pair existente** si quieres acceso SSH: el nombre en `key_name` debe
      existir previamente en la cuenta y región destino.
- [ ] **CIDR de SSH** restringido a tu IP en entornos no efímeros:
      `ssh_allowed_cidr = "TU_IP/32"`.
- [ ] **Cuota de instancias** t2.micro está cubierta por el Free Tier (primeros 12 meses,
      750 h/mes). Verifica que no excedas el límite de tu cuenta.

---

## ⚠️ Precauciones importantes

> **El Security Group abre el puerto 22 a `0.0.0.0/0` por defecto.**
> Cambia `ssh_allowed_cidr` a tu IP antes de desplegar en un entorno real.

> **La instancia no tiene key pair por defecto**, por lo que no podrás conectarte
> por SSH a menos que asignes uno con `-var="key_name=<nombre>"`.

---

## Outputs tras el despliegue

```bash
# Ver todos los outputs
terraform output

# Conectarse por SSH (si se asignó un key pair)
ssh -i ~/.ssh/<llave>.pem ec2-user@$(terraform output -raw instance_public_ip)
```

---

## Destruir la infraestructura

```bash
terraform destroy
```

