# Tarea: Infraestructura EC2 con Kiro

**Autor:** Gabriel Ramírez

## Prompt enviado a Kiro

```
creacion de una rama en el repo — Objetivo: Con kiro crear la infra para una Instancia EC2
```

## Créditos usados

| Concepto | Valor |
|----------|-------|
| Créditos gastados en esta tarea | ~7,000 tokens |

## Qué crea esta infra

Una instancia EC2 `t2.micro` con Amazon Linux 2023 en `us-east-1`.

## Archivos

| Archivo | Descripción |
|---------|-------------|
| `main.tf` | Proveedor AWS y recurso `aws_instance` |
| `variables.tf` | Región, AMI e instance type |
| `outputs.tf` | ID e IP pública de la instancia |

## Cómo aplicar

```bash
terraform init
terraform plan
terraform apply
```

> **Nota:** necesitas credenciales AWS configuradas (`aws configure` o variables de entorno).
