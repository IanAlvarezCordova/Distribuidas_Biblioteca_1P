-- Script para poblar la base de datos de la biblioteca digital
-- Asume que las tablas ya están creadas y que existen roles con id=1 (usuario final) y id=2 (administrador)
-- Ejecutar en PostgreSQL (bd-biblioteca)

INSERT INTO public.usuario
(nombre, apellido, username, email, "password", activo, ultimo_acceso, "creadoEn", "actualizadoEn")
VALUES
    ('Juan', 'Perez', 'jperez', 'juan.perez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW()),
    ('Ana', 'Gomez', 'agomez', 'ana.gomez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW()),
    ('Carlos', 'Lopez', 'clopez', 'carlos.lopez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW()),
    ( 'Maria', 'Rodriguez', 'mrodriguez', 'maria.rodriguez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW()),
    ('Pedro', 'Sanchez', 'psanchez', 'pedro.sanchez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW()),
    ('Laura', 'Martinez', 'lmartinez', 'laura.martinez@example.com', '$2b$10$XURPShQNCsLjp1ESc2laoObo9QZDhxz73hJPaEv7/cBha4pk0AgP.', true, NULL, NOW(), NOW());

    
    -- 2. Asignar roles a usuarios
INSERT INTO rol_usuario ("rolId", "usuarioId")
VALUES
    (2, (SELECT id FROM usuario WHERE username = 'jperez')), -- admin
    (1, (SELECT id FROM usuario WHERE username = 'jperez')),
    (1, (SELECT id FROM usuario WHERE username = 'agomez')),
    (1, (SELECT id FROM usuario WHERE username = 'clopez')),
    (1, (SELECT id FROM usuario WHERE username = 'mrodriguez')),
    (1, (SELECT id FROM usuario WHERE username = 'psanchez')),
    (1, (SELECT id FROM usuario WHERE username = 'lmartinez'));


-- 3. Insertar categorías
INSERT INTO categorias (nombre, "creadoEn", "actualizadoEn")
VALUES
    ('Ficción', NOW(), NOW()),
    ('No Ficción', NOW(), NOW()),
    ('Ciencia Ficción', NOW(), NOW()),
    ('Historia', NOW(), NOW()),
    ('Tecnología', NOW(), NOW()),
    ('Literatura Infantil', NOW(), NOW());

-- 4. Insertar autores
INSERT INTO autores (nombre, "creadoEn", "actualizadoEn")
VALUES
    ('Gabriel García Márquez', NOW(), NOW()),
    ('Jane Austen', NOW(), NOW()),
    ('Isaac Asimov', NOW(), NOW()),
    ('Yuval Noah Harari', NOW(), NOW()),
    ('J.K. Rowling', NOW(), NOW()),
    ('Antoine de Saint-Exupéry', NOW(), NOW())


-- 5. Insertar libros
INSERT INTO libros (titulo, descripcion, fecha_publicacion, disponible, "categoriaId", "autorId", "creadoEn", "actualizadoEn")
VALUES
    ('Cien años de soledad', 'Saga familiar en Macondo', '1967-05-30', false, 1, 1, NOW(), NOW()),
    ('Orgullo y prejuicio', 'Romance en la Inglaterra del siglo XIX', '1813-01-28', true, 1, 2, NOW(), NOW()),
    ('Fundación', 'Epopeya galáctica', '1951-06-01', false, 3, 3, NOW(), NOW()),
    ('Sapiens', 'Historia de la humanidad', '2011-02-10', true, 2, 4, NOW(), NOW()),
    ('Harry Potter y la piedra filosofal', 'Aventuras de un joven mago', '1997-06-26', false, 3, 5, NOW(), NOW()),
    ('El principito', 'Cuento filosófico', '1943-04-06', true, 6, 6, NOW(), NOW());



-- 6. Insertar préstamos
INSERT INTO prestamos (id, fecha_prestamo, fecha_devolucion, devuelto, "creadoEn", "actualizadoEn", "usuarioId", "libroId")
VALUES
    (DEFAULT, '2025-05-20', '2025-06-03', false, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'agomez'), 1),
    (DEFAULT, '2025-05-18', '2025-06-01', false, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'clopez'), 3),
    (DEFAULT, '2025-05-22', '2025-06-05', false, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'mrodriguez'), 5),
    (DEFAULT, '2025-05-10', '2025-05-17', true, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'agomez'), 2),
    (DEFAULT, '2025-05-12', '2025-05-19', true, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'clopez'), 4),
    (DEFAULT, '2025-05-15', '2025-05-22', true, NOW(), NOW(), (SELECT id FROM usuario WHERE username = 'psanchez'), 6);

-- 7. Asegurar estado 'disponible' en libros correcto
UPDATE libros SET disponible = false WHERE id IN (1, 3, 5);
UPDATE libros SET disponible = true WHERE id IN (2, 4, 6);
