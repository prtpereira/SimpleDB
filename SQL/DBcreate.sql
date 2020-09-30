-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ginasio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ginasio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ginasio` DEFAULT CHARACTER SET utf8 ;
USE `ginasio` ;

-- -----------------------------------------------------
-- Table `ginasio`.`Localidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Localidade` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Localidade` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Morada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Morada` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `CodigoPostal` VARCHAR(8) NOT NULL,
  `Rua` VARCHAR(45) NOT NULL,
  `Localidade_id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Morada_Localidade1_idx` (`Localidade_id` ASC),
  CONSTRAINT `fk_Morada_Localidade1`
    FOREIGN KEY (`Localidade_id`)
    REFERENCES `ginasio`.`Localidade` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Contrato` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NULL,
  `Entrada` TIME NOT NULL,
  `Saida` TIME NOT NULL,
  `Mensalidade` INT NOT NULL,
  `Inicio` DATE NOT NULL,
  `Fim` DATE NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Cliente` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Nascimento` DATE NOT NULL,
  `Cartao` INT NOT NULL,
  `ContactoEmergencia` VARCHAR(9) NULL,
  `Telefone` VARCHAR(9) NOT NULL,
  `Email` VARCHAR(100) NULL,
  `TotalPago` INT NOT NULL,
  `PagoAte` DATE NOT NULL,
  `Contrato_id` INT NOT NULL,
  `Morada_id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE INDEX `Cartao_UNIQUE` (`Cartao` ASC),
  INDEX `fk_Cliente_Morada1_idx` (`Morada_id` ASC),
  INDEX `fk_Cliente_Contrato1_idx` (`Contrato_id` ASC),
  CONSTRAINT `fk_Cliente_Morada1`
    FOREIGN KEY (`Morada_id`)
    REFERENCES `ginasio`.`Morada` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Contrato1`
    FOREIGN KEY (`Contrato_id`)
    REFERENCES `ginasio`.`Contrato` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Professor` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Nascimento` DATE NOT NULL,
  `Telefone` VARCHAR(12) NOT NULL,
  `Morada_id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Funcionario_Morada1_idx` (`Morada_id` ASC),
  CONSTRAINT `fk_Funcionario_Morada1`
    FOREIGN KEY (`Morada_id`)
    REFERENCES `ginasio`.`Morada` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`TiposAula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`TiposAula` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(45) NOT NULL,
  `Duracao` INT NOT NULL,
  `Lotacao` INT NOT NULL,
  `Sala` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Aula` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Dia` DATETIME NOT NULL,
  `Professor_id` INT NOT NULL,
  `TiposAula_id` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Aula_Funcionario1_idx` (`Professor_id` ASC),
  INDEX `fk_Aula_TiposAula1_idx` (`TiposAula_id` ASC),
  CONSTRAINT `fk_Aula_Funcionario1`
    FOREIGN KEY (`Professor_id`)
    REFERENCES `ginasio`.`Professor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Aula_TiposAula1`
    FOREIGN KEY (`TiposAula_id`)
    REFERENCES `ginasio`.`TiposAula` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`Entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`Entrada` (
  `Cliente_id` INT NOT NULL,
  `Aula_id` INT NOT NULL,
  `HoraEntrada` DATETIME NOT NULL,
  `HoraSaida` DATETIME NULL,
  INDEX `fk_Participou_Cliente1_idx` (`Cliente_id` ASC),
  INDEX `fk_Participou_Aula1_idx` (`Aula_id` ASC),
  PRIMARY KEY (`Cliente_id`, `Aula_id`),
  CONSTRAINT `fk_Participou_Cliente1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `ginasio`.`Cliente` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Participou_Aula1`
    FOREIGN KEY (`Aula_id`)
    REFERENCES `ginasio`.`Aula` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ginasio`.`podeParticipar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ginasio`.`podeParticipar` (
  `Contrato` INT NOT NULL,
  `TiposAula` INT NOT NULL,
  INDEX `fk_podeParticipar_contrato1_idx` (`Contrato` ASC),
  INDEX `fk_podeParticipar_TiposAula1_idx` (`TiposAula` ASC),
  PRIMARY KEY (`Contrato`, `TiposAula`),
  CONSTRAINT `fk_podeParticipar_contrato1`
    FOREIGN KEY (`Contrato`)
    REFERENCES `ginasio`.`Contrato` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_podeParticipar_TiposAula1`
    FOREIGN KEY (`TiposAula`)
    REFERENCES `ginasio`.`TiposAula` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
