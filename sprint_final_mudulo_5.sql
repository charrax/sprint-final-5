CREATE DATABASE `en que te puedo ayudar`;

 CREATE USER 'app_admin'@'localhost' IDENTIFIED BY 'admin12345';
 GRANT ALL PRIVILEGES ON online_store.* TO  'app_admin'@'localhost';
 FLUSH PRIVILEGES;
 
USE `en que te puedo ayudar`;

-- -----------------------------------------------------
-- Table `en que te puedo ayudar`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `en que te puedo ayudar`.`usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NULL,
  `edad` INT NULL,
  `correo` VARCHAR(100) NULL,
  `n_veces` INT NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `en que te puedo ayudar`.`operario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `en que te puedo ayudar`.`operario` (
  `id_operario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `edad` INT NOT NULL,
  `correo` VARCHAR(100) NULL,
  `n_soporte` INT NULL,
  PRIMARY KEY (`id_operario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `en que te puedo ayudar`.`soporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `en que te puedo ayudar`.`soporte` (
   `n_soporte` INT NOT NULL AUTO_INCREMENT,
  `id_operario` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha` DATE NULL,
  `evaluación` INT NOT NULL,
   PRIMARY KEY (`n_soporte`))
  ENGINE = InnoDB;
-- 5 usuarios

INSERT INTO usuario (nombre, apellido,edad, correo, n_veces) VALUES
('Juan Daniel',  'Carrasco Flores', 20, 'juan.perez@example.com', 50),
('Laura Andrea', 'Romero Lepe', 40, 'laura.mtz@example.com', 100),
('Carlos Antobio', 'Geve Carrasco', 43,'carlos.gomez@example.com', 20),
('Isabel Carla',  'Beltran Romero', 25, 'isabel.diaz@example.com', 60),
('Antonio Pedro', 'Lopez Lopez', 34, 'antoni@example.com',500);
select* from usuario;

-- 10 operaciones
INSERT INTO soporte ( id_operario,id_usuario, fecha, evaluación) VALUES
(1,1,'2024-03-20', 1),
(1,4,'2024-05-20', 5),
(1,2,'2024-05-02', 2),
(4,2,'2024-05-20', 7),
(5,3,'2024-06-20', 7),
(5,3,'2024-05-20', 3),
(2,5,'2021-02-28', 4),
(2,5,'2023-11-11', 5),
(3,5,'2022-02-21', 6),
(4,5,'2024-03-10', 5);
select* from soporte;

-- 5 operadores
INSERT INTO operario (nombre, apellido,edad, correo) VALUES
('Veronica Isabel', 'Pantoja Beltran', 20, 'isabel@diaz.com'),
('Luis Antonio', 'Herrera Lopez', 24, 'antonio@lop.com'),
('Sofia Bella', 'Vergara Lepe', 33,'sofia@castrom.com'),
('Lucas Loreto', 'Galvez Toro', 43,'lucas@fercom.com'),
('Beatriz Josefina', 'Sanchez Herrera',50,'beatrizple@lili.com');
select* from operario;

-- Seleccione las 3 operaciones con mejor evaluación.
SELECT *  FROM soporte ORDER BY evaluación DESC  LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.
SELECT *  FROM soporte ORDER BY evaluación ASC  LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.
SELECT 	operario.nombre, COUNT(*) as 'N° de Soportes'
from operario JOIN soporte ON operario.id_operario = soporte.id_operario 
GROUP BY operario.id_operario 
ORDER BY count(operario.id_operario) DESC LIMIT 1; 
    -- se deja siguente codigo par fines posteriores
    -- SELECT 	operario.nombre from operario JOIN soporte ON operario.id_operario = soporte.id_operario; 
    -- SELECT id_operario, COUNT(*) as soportes FROM soporte GROUP BY id_operario ORDER BY count(id_operario) DESC LIMIT 1;
    
-- Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT *from usuario;
SELECT nombre,  n_veces AS 'N° de Veces' FROM usuario WHERE n_veces = (SELECT MIN(n_veces) FROM usuario) ORDER BY nombre;
-- Agregue 10 años a los tres primeros usuarios registrados
update soporte set fecha=Year(fecha)+1;
-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
EXECUTE sp_rename 'en que te puedo ayudar.usuario.correo','email', 'Column';
EXECUTE sp_rename 'en que te puedo ayudar.operario.correo','email', 'Column';
-- Seleccione solo los operarios mayores de 20 años.
SELECT nombre  FROM operario WHERE edad > 20  ORDER BY nombre;
SELECT *from operario;


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
