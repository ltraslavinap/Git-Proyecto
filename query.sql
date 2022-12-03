-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`departamento` (
  `iddepartamento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddepartamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ciudad` (
  `idciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `iddepartamento` INT NOT NULL,
  PRIMARY KEY (`idciudad`),
  INDEX `fk_ciudad_departamento_idx` (`iddepartamento` ASC) VISIBLE,
  CONSTRAINT `fk_ciudad_departamento`
    FOREIGN KEY (`iddepartamento`)
    REFERENCES `mydb`.`departamento` (`iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipousuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipousuarios` (
  `idtipousuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtipousuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `documento` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `idtipousuario` INT NOT NULL,
  `idciudad` INT NOT NULL,
  `iddepartamento` INT NOT NULL,
  PRIMARY KEY (`documento`),
  INDEX `fk_usuarios_ciudad_idx` (`idciudad` ASC) VISIBLE,
  INDEX `fk_usuarios_departamento_idx` (`iddepartamento` ASC) VISIBLE,
  INDEX `fk_usuarios_tipousuarios_idx` (`idtipousuario` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_ciudad`
    FOREIGN KEY (`idciudad`)
    REFERENCES `mydb`.`ciudad` (`idciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_departamento`
    FOREIGN KEY (`iddepartamento`)
    REFERENCES `mydb`.`departamento` (`iddepartamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_tipousuarios`
    FOREIGN KEY (`idtipousuario`)
    REFERENCES `mydb`.`tipousuarios` (`idtipousuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`talla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`talla` (
  `idtalla` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtalla`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `nombreprod` VARCHAR(45) NOT NULL,
  `cantidadprod` INT NOT NULL,
  `valorprod` INT NOT NULL,
  `idcategoria` INT NOT NULL,
  `idtalla` INT NOT NULL,
  `documento` INT NOT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_productos_usuarios_idx` (`documento` ASC) VISIBLE,
  INDEX `fk_productos_categoria_idx` (`idcategoria` ASC) VISIBLE,
  INDEX `fk_productos_talla_idx` (`idtalla` ASC) VISIBLE,
  CONSTRAINT `fk_productos_usuarios`
    FOREIGN KEY (`documento`)
    REFERENCES `mydb`.`usuarios` (`documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_categoria`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `mydb`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_talla`
    FOREIGN KEY (`idtalla`)
    REFERENCES `mydb`.`talla` (`idtalla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`compras` (
  `idcompras` INT NOT NULL,
  `nombreprod` VARCHAR(45) NOT NULL,
  `cantidad` INT NOT NULL,
  `valor` INT NOT NULL,
  `total` INT NOT NULL,
  `idproductos` INT NOT NULL,
  `documento` INT NOT NULL,
  PRIMARY KEY (`idcompras`),
  INDEX `fk_compras_productos_idx` (`idproductos` ASC) VISIBLE,
  INDEX `fk_compras_usuarios_idx` (`documento` ASC) VISIBLE,
  CONSTRAINT `fk_compras_productos`
    FOREIGN KEY (`idproductos`)
    REFERENCES `mydb`.`productos` (`idproductos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compras_usuarios`
    FOREIGN KEY (`documento`)
    REFERENCES `mydb`.`usuarios` (`documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
