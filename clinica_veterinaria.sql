-- ==========================================
-- 1. CREACIÓN DE BASE DE DATOS Y TABLAS
-- ==========================================

-- En PostgreSQL, primero creamos la base de datos
-- CREATE DATABASE clinica_veterinaria;

-- Tabla Dueño: Usamos SERIAL para que el ID sea autoincremental
CREATE TABLE Dueno (
    id_dueno SERIAL PRIMARY KEY, -- SERIAL crea una secuencia automática
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20)
);

-- Tabla Profesional
CREATE TABLE Profesional (
    id_profesional SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100)
);

-- Tabla Mascota: Relacionada con Dueno
CREATE TABLE Mascota (
    id_mascota SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50), 
    fecha_nacimiento DATE,
    id_dueno INT,
    -- CONSTRAINT define la integridad: si borro un dueño, desaparecen sus mascotas
    CONSTRAINT fk_dueno FOREIGN KEY (id_dueno) 
        REFERENCES Dueno(id_dueno) ON DELETE CASCADE
);

-- Tabla Atencion: Relaciona Mascota y Profesional
CREATE TABLE Atencion (
    id_atencion SERIAL PRIMARY KEY,
    fecha_atencion DATE NOT NULL DEFAULT CURRENT_DATE,
    descripcion TEXT,
    id_mascota INT,
    id_profesional INT,
    CONSTRAINT fk_mascota FOREIGN KEY (id_mascota) REFERENCES Mascota(id_mascota),
    CONSTRAINT fk_profesional FOREIGN KEY (id_profesional) REFERENCES Profesional(id_profesional)
);

-- ==========================================
-- 2. CARGA DE DATOS (DML)
-- ==========================================

INSERT INTO Dueno (nombre, direccion, telefono) VALUES 
('Felipe Camiroaga', 'Isla Friendship', '112233'),
('Claudiomon', 'Recoleta gba hackroom', '445566'),
('Miguelito', 'Prision de Kike', '778899');

INSERT INTO Profesional (nombre, especialidad) VALUES 
('Dr. Martínez', 'Veterinario'),
('Dr. Pérez', 'Especialista en dermatología'),
('Dr. López', 'Cardiólogo veterinario');

-- Nota: En Postgres el formato de fecha estándar es 'YYYY-MM-DD'
INSERT INTO Mascota (nombre, tipo, fecha_nacimiento, id_dueno) VALUES 
('Domino', 'Caballo', '2008-09-18', 1),
('Guru Guru', 'Pokemon', '1999-09-19', 2),
('Troll', 'Rata', '2025-01-10', 3);

INSERT INTO Atencion (fecha_atencion, descripcion, id_mascota, id_profesional) VALUES 
('2025-03-01', 'Chequeo general', 1, 1),
('2025-03-05', 'Tratamiento dermatológico', 2, 2),
('2025-03-07', 'Consulta cardiológica', 3, 3);

-- ==========================================
-- 3. CONSULTAS REQUERIDAS
-- ==========================================

-- 1. Dueños y sus mascotas (JOIN simple)
SELECT d.nombre AS dueno, m.nombre AS mascota 
FROM Dueno d 
INNER JOIN Mascota m ON d.id_dueno = m.id_dueno;

-- 2. Atenciones con detalle de profesional (Triple JOIN)
SELECT a.fecha_atencion, m.nombre AS mascota, p.nombre AS veterinario, a.descripcion
FROM Atencion a
JOIN Mascota m ON a.id_mascota = m.id_mascota
JOIN Profesional p ON a.id_profesional = p.id_profesional;

-- 3. Conteo de atenciones por profesional (Agregación)
SELECT p.nombre, COUNT(a.id_atencion) AS total_atenciones
FROM Profesional p
LEFT JOIN Atencion a ON p.id_profesional = a.id_profesional
GROUP BY p.nombre;

-- 4. Actualización
UPDATE Dueno SET direccion = 'Nueva Calle Falsa 123' WHERE id_dueno = 1;

-- 5. Eliminación
DELETE FROM Atencion WHERE id_atencion = 2;

-- 6. TRANSACCIÓN (Atomicidad en Postgres)
BEGIN;
    -- Insertar nueva mascota
    INSERT INTO Mascota (nombre, tipo, fecha_nacimiento, id_dueno) 
    VALUES ('Chuchu', 'Perro', '2024-05-20', 3);
    
    -- Insertar atención usando el último ID de la secuencia (RETURNING o subconsulta)
    INSERT INTO Atencion (fecha_atencion, descripcion, id_mascota, id_profesional)
    VALUES (CURRENT_DATE, 'Control preventivo', (SELECT MAX(id_mascota) FROM Mascota), 1);
COMMIT;