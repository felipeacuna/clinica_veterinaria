# 🐾 Sistema de Gestión: Clínica Veterinaria "Mundo Animal"

Proyecto desarrollado como parte del **Bootcamp de Full Stack Python**. Este sistema implementa una base de datos relacional robusta en **PostgreSQL** para la gestión integral de una clínica veterinaria, incluyendo dueños, pacientes, profesionales y registros de atención.

## 🛠️ Tecnologías Utilizadas
* **Motor de Base de Datos:** PostgreSQL 16+
* **Herramienta de Gestión:** pgAdmin 4
* **Lenguaje:** SQL (Postgres Dialect)
* **Conceptos Aplicados:** DDL (Estructura), DML (Manipulación), Transacciones (ACID), Integridad Referencial.

## 📊 Modelo de Datos
El diseño consta de 4 tablas interconectadas:
1. **Dueno:** Registro de clientes y contacto.
2. **Mascota:** Información de pacientes (Relación 1:N con Dueño).
3. **Profesional:** Staff médico y especialidades.
4. **Atencion:** Registro histórico de consultas médicos (Tabla relacional).

## 🚀 Funcionalidades Principales
* **Integridad de Datos:** Uso de `FOREIGN KEYS` con `ON DELETE CASCADE`.
* **Consultas Avanzadas:** Cruce de información mediante `INNER JOIN` y `LEFT JOIN`.
* **Reportes:** Conteo automatizado de atenciones por especialista.
* **Seguridad Operacional:** Implementación de bloques `BEGIN...COMMIT` para asegurar que las inserciones múltiples sean atómicas.

## 📝 Instrucciones de Uso
1. Clonar este repositorio.
2. Ejecutar el script `script_clinica.sql` en su instancia de PostgreSQL (vía pgAdmin o psql).
3. Las consultas de prueba se encuentran al final del archivo SQL para validación inmediata.

---
**Desarrollado por:** Felipe Acuña  
**Fecha:** Marzo 2026
