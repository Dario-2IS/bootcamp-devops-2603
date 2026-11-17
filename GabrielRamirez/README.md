# Tarea: Infraestructura EC2 con Kiro

**Autor:** Gabriel Ramírez

## Prompt enviado a Kiro

```
<!-- REEMPLAZAR: pega aquí el prompt exacto que le enviaste a Kiro para generar esta infra -->
```

## Créditos usados

| Concepto | Valor |
|----------|-------|
| Créditos gastados en esta tarea | <!-- REEMPLAZAR: ej. 0.023 USD --> |

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
