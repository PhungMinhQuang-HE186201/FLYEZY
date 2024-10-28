-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema flyezy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flyezy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flyezy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `flyezy` ;

-- -----------------------------------------------------
-- Table `flyezy`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Airline` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Airline_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `fk_Airline_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Accounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Accounts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `phoneNumber` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `Rolesid` INT NOT NULL,
  `Airlineid` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  INDEX `FKAccounts201294` (`Rolesid` ASC) VISIBLE,
  INDEX `FKAccounts898886` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Accounts_Status1_idx` (`Status_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKAccounts201294`
    FOREIGN KEY (`Rolesid`)
    REFERENCES `flyezy`.`Roles` (`id`),
  CONSTRAINT `FKAccounts898886`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Accounts_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flyezy`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `Country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Location_Country1_idx` (`Country_id` ASC) VISIBLE,
  CONSTRAINT `fk_Location_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `flyezy`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Airport` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `Locationid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKAirport14562` (`Locationid` ASC) VISIBLE,
  CONSTRAINT `FKAirport14562`
    FOREIGN KEY (`Locationid`)
    REFERENCES `flyezy`.`Location` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Baggages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Baggages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `weight` FLOAT NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `Airlineid` INT NOT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKBaggages227358` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Baggages_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKBaggages227358`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Baggages_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Discount` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `percentage` DECIMAL(5,2) NULL DEFAULT NULL,
  `Airline_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Discount_Airline1_idx` (`Airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_Discount_Airline1`
    FOREIGN KEY (`Airline_id`)
    REFERENCES `flyezy`.`Airline` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Payment_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Payment_Types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `contactName` VARCHAR(45) NOT NULL,
  `contactPhone` VARCHAR(45) NOT NULL,
  `contactEmail` VARCHAR(45) NOT NULL,
  `totalPrice` INT NOT NULL,
  `Accounts_id` INT NULL,
  `Payment_Types_id` INT NULL,
  `paymentTime` TIMESTAMP NULL,
  `created_at` TIMESTAMP NOT NULL,
  `Discount_id` INT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Order_Accounts1_idx` (`Accounts_id` ASC) VISIBLE,
  INDEX `fk_Order_Payment_Types1_idx` (`Payment_Types_id` ASC) VISIBLE,
  INDEX `fk_Order_Discount1_idx` (`Discount_id` ASC) VISIBLE,
  INDEX `fk_Order_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Accounts1`
    FOREIGN KEY (`Accounts_id`)
    REFERENCES `flyezy`.`Accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Payment_Types1`
    FOREIGN KEY (`Payment_Types_id`)
    REFERENCES `flyezy`.`Payment_Types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Discount1`
    FOREIGN KEY (`Discount_id`)
    REFERENCES `flyezy`.`Discount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flyezy`.`Feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Feedbacks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Accountsid` INT NOT NULL,
  `ratedStar` INT NULL DEFAULT NULL,
  `comment` VARCHAR(255) NULL DEFAULT NULL,
  `date` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  `Statusid` INT NOT NULL,
  `Order_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKFeedbacks957463` (`Accountsid` ASC) VISIBLE,
  INDEX `FKFeedbacks883062` (`Statusid` ASC) VISIBLE,
  INDEX `fk_Feedbacks_Order1_idx` (`Order_id` ASC) VISIBLE,
  CONSTRAINT `FKFeedbacks883062`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`),
  CONSTRAINT `FKFeedbacks957463`
    FOREIGN KEY (`Accountsid`)
    REFERENCES `flyezy`.`Accounts` (`id`),
  CONSTRAINT `fk_Feedbacks_Order1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `flyezy`.`Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `minutes` INT NULL DEFAULT NULL,
  `departureAirportid` INT NOT NULL,
  `destinationAirportid` INT NOT NULL,
  `Status_id` INT NOT NULL,
  `Airline_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKFlight90325` (`departureAirportid` ASC) VISIBLE,
  INDEX `FKFlight563127` (`destinationAirportid` ASC) VISIBLE,
  INDEX `fk_Flight_Status1_idx` (`Status_id` ASC) VISIBLE,
  INDEX `fk_Flight_Airline1_idx` (`Airline_id` ASC) VISIBLE,
  CONSTRAINT `FKFlight563127`
    FOREIGN KEY (`destinationAirportid`)
    REFERENCES `flyezy`.`Airport` (`id`),
  CONSTRAINT `FKFlight90325`
    FOREIGN KEY (`departureAirportid`)
    REFERENCES `flyezy`.`Airport` (`id`),
  CONSTRAINT `fk_Flight_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airline1`
    FOREIGN KEY (`Airline_id`)
    REFERENCES `flyezy`.`Airline` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Plane_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Plane_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `Airlineid` INT NOT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKPlane_Cate276706` (`Airlineid` ASC) VISIBLE,
  INDEX `fk_Plane_Category_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKPlane_Cate276706`
    FOREIGN KEY (`Airlineid`)
    REFERENCES `flyezy`.`Airline` (`id`),
  CONSTRAINT `fk_Plane_Category_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Flight_Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight_Detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `time` TIME NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `Flightid` INT NOT NULL,
  `Plane_Categoryid` INT NOT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKFlight_Det484575` (`Flightid` ASC) VISIBLE,
  INDEX `FKFlight_Det564449` (`Plane_Categoryid` ASC) VISIBLE,
  INDEX `fk_Flight_Detail_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKFlight_Det484575`
    FOREIGN KEY (`Flightid`)
    REFERENCES `flyezy`.`Flight` (`id`),
  CONSTRAINT `FKFlight_Det564449`
    FOREIGN KEY (`Plane_Categoryid`)
    REFERENCES `flyezy`.`Plane_Category` (`id`),
  CONSTRAINT `fk_Flight_Detail_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Flight_Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Flight_Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`News_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`News_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`News`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`News` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL,
  `content` TEXT NULL DEFAULT NULL,
  `News_Categoryid` INT NOT NULL,
  `Accountsid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKNews232818` (`News_Categoryid` ASC) VISIBLE,
  INDEX `FKNews924154` (`Accountsid` ASC) VISIBLE,
  CONSTRAINT `FKNews232818`
    FOREIGN KEY (`News_Categoryid`)
    REFERENCES `flyezy`.`News_Category` (`id`),
  CONSTRAINT `FKNews924154`
    FOREIGN KEY (`Accountsid`)
    REFERENCES `flyezy`.`Accounts` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Passenger_Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Passenger_Types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Seat_Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Seat_Category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `numberOfSeat` INT NULL DEFAULT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `Plane_Categoryid` INT NOT NULL,
  `info` TEXT NULL DEFAULT NULL,
  `seatEachRow` INT NOT NULL,
  `surcharge` FLOAT NOT NULL,
  `Status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKSeat_Categ529738` (`Plane_Categoryid` ASC) VISIBLE,
  INDEX `fk_Seat_Category_Status1_idx` (`Status_id` ASC) VISIBLE,
  CONSTRAINT `FKSeat_Categ529738`
    FOREIGN KEY (`Plane_Categoryid`)
    REFERENCES `flyezy`.`Plane_Category` (`id`),
  CONSTRAINT `fk_Seat_Category_Status1`
    FOREIGN KEY (`Status_id`)
    REFERENCES `flyezy`.`Status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Seat_Categoryid` INT NOT NULL,
  `Passenger_Typesid` INT NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `pName` VARCHAR(255) NOT NULL,
  `pSex` BIT(1) NOT NULL,
  `pPhoneNumber` VARCHAR(10) NOT NULL,
  `pDob` DATE NOT NULL,
  `Baggagesid` INT NULL DEFAULT NULL,
  `totalPrice` INT NOT NULL,
  `Order_id` INT NOT NULL,
  `Statusid` INT NOT NULL,
  `Flight_Type_id` INT NOT NULL,
  `Flight_Detail_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKTicket339557` (`Passenger_Typesid` ASC) VISIBLE,
  INDEX `FKTicket999927` (`Baggagesid` ASC) VISIBLE,
  INDEX `FKTicket721068` (`Seat_Categoryid` ASC) VISIBLE,
  INDEX `FKTicket601957` (`Statusid` ASC) VISIBLE,
  INDEX `fk_Ticket_Order1_idx` (`Order_id` ASC) VISIBLE,
  INDEX `fk_Ticket_Flight_Type1_idx` (`Flight_Type_id` ASC) VISIBLE,
  INDEX `fk_Ticket_Flight_Detail1_idx` (`Flight_Detail_id` ASC) VISIBLE,
  CONSTRAINT `FKTicket339557`
    FOREIGN KEY (`Passenger_Typesid`)
    REFERENCES `flyezy`.`Passenger_Types` (`id`),
  CONSTRAINT `FKTicket601957`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`),
  CONSTRAINT `FKTicket721068`
    FOREIGN KEY (`Seat_Categoryid`)
    REFERENCES `flyezy`.`Seat_Category` (`id`),
  CONSTRAINT `FKTicket999927`
    FOREIGN KEY (`Baggagesid`)
    REFERENCES `flyezy`.`Baggages` (`id`),
  CONSTRAINT `fk_Ticket_Order1`
    FOREIGN KEY (`Order_id`)
    REFERENCES `flyezy`.`Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Flight_Type1`
    FOREIGN KEY (`Flight_Type_id`)
    REFERENCES `flyezy`.`Flight_Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Flight_Detail1`
    FOREIGN KEY (`Flight_Detail_id`)
    REFERENCES `flyezy`.`Flight_Detail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `flyezy`.`Refund`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flyezy`.`Refund` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `bank` VARCHAR(255) NULL DEFAULT NULL,
  `bankAccount` VARCHAR(255) NULL DEFAULT NULL,
  `requestDate` TIMESTAMP NULL,
  `refundDate` TIMESTAMP NULL,
  `Ticketid` INT NOT NULL,
  `Statusid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKRefund25985` (`Ticketid` ASC) VISIBLE,
  INDEX `FKRefund748756` (`Statusid` ASC) VISIBLE,
  CONSTRAINT `FKRefund25985`
    FOREIGN KEY (`Ticketid`)
    REFERENCES `flyezy`.`Ticket` (`id`),
  CONSTRAINT `FKRefund748756`
    FOREIGN KEY (`Statusid`)
    REFERENCES `flyezy`.`Status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- ------------------------------------------------
-- INSERT DATA
---------------------------------------------------
INSERT INTO `Status` VALUES (1,'Activated'),(2,'Deactivated'),(3,'Pre-flight'),(4,'In-flight'),(5,'Landed'),(6,'Cancellation Request'),(7,'Successfully Canceled'),(8,'Refund completed'),(9,'Is Empty'),(10,'Successful Payment'),(11,'Cancellation Rejection'), ('12', 'Is Pending');

INSERT INTO `Roles` VALUES 
(1,'Admin'),
(2,'Airline Staff'),
(3,'Member'),
(4,'Service Staff');

INSERT INTO `Airline` VALUES 
(1,'Empty','img/empty.jpg',NULL, 1),
(2,'Vietnam Airline','img/vietnam-airline.png',NULL, 1),
(3,'Bamboo Airway','img/bamboo-airway.png',NULL, 1),
(4,'Vietjet Air','img/vietjet.jpg',NULL, 1);

INSERT INTO `Baggages` VALUES (4,10,180000,3,1),(5,20,310000,3,1),(6,30,440000,3,1),(7,40,570000,3,1),(8,50,700000,3,1),(9,60,830000,3,1),(10,20,266000,4,1),(11,30,374000,4,1),(12,40,482000,4,1),(13,50,644000,4,1),(14,60,752000,4,1),(15,70,860000,4,1),(16,10,200000,2,1),(17,20,350000,2,1),(18,30,500000,2,1);

INSERT INTO `Accounts` VALUES 
(1,'Ngô Tùng Dương','duongnthe186310@fpt.edu.vn','KIymfC4XfLDNFnygtZuXNQ==','0862521226','','img/avatar.jpg','2004-11-16',1,3,'2024-09-23 14:07:56','2024-09-23 14:20:15', 1),
(2,'Hồ Trần Quân','abc@gmail.com','KIymfC4XfLDNFnygtZuXNQ==','0123','','img/jack.png','2024-09-18',2,2,'2024-09-23 14:19:19',NULL, 1);

INSERT INTO Plane_Category 
VALUES 
  (1,'Airbus A321CEO','img/Airbus A321CEO.png',3,NULL,1),
  (2,'Airbus A320NEO','img/Airbus A320NEO.png',3,NULL,1),
  (3,'Airbus A320CEO','img/Airbus A320CEO.png',3,NULL,1),
  (4,'Airbus A321','img/vnairline-AIRBUS A321.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 5.600 km</p><p>Vận tốc (km/h): 950 km/h</p><p>Số ghế (*): 184</p><p>Tổng chiều dài: 44,51 m</p><p>Sải cánh: 34,1 m</p><p>Chiều cao: 11,76 m</p>',1),
  (5,'BOEING 787','img/vnairline-BOEING 787.png',2,'<p>Nhà sản xuất: Boeing</p><p>Khoảng cách tối đa (km): 15.750 km</p><p>Vận tốc (km/h): 954 km/h</p><p>Tổng chiều dài: 63.73 m</p><p>Sải cánh: 60.93 m</p><p>Chiều cao: 18.76 m</p>',1),
  (6,'AIRBUS A350','img/vnairline-AIRBUS A350.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 14.350 km</p><p>Vận tốc (km/h): 901 km/h</p><p>Tổng chiều dài: 66.89 m</p><p>Sải cánh: 64.75 m</p><p>Chiều cao: 17.05 m</p>',1),
  (7,'AIRBUS A320 NEO','img/vnairline-AIRBUS A320 NEO.png',2,'<p>Nhà sản xuất: Airbus</p><p>Khoảng cách tối đa (km): 6.300 km</p><p>Vận tốc (km/h): 1.005 km/h</p><p>Tổng chiều dài: 37,57 m</p><p>Sải cánh: 35,8 m</p><p>Chiều cao: 11,76 m</p>',1);

INSERT INTO `flyezy`.`Seat_Category` 
(`id`, `name`, `numberOfSeat`, `image`, `Plane_Categoryid`, `info`, `seatEachRow`, `surcharge`, `Status_id`)
VALUES 
  (1, 'Economy', 184, 'img/bamboo-economy.jpg', 1, '<ul><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hành lý xách tay: 7kg</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Thay đổi trước giờ khởi hành: 600.000 VND (*)</span><br><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Không thay đổi sau giờ khởi hành (*)</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hệ số cộng điểm Flyezy Club: 0.25</span></li></ul>', 6, 0, 1),
  (2, 'Business', 8, 'img/bamboo-business.jpg', 1, '<ul><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hành lý xách tay: 2 kiện, 7kg/kiện</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">01 kiện hành lý ký gửi 40kg</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hoàn/huỷ trước giờ khởi hành: 300.000 VND (*)</span><br><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hoàn/huỷ sau giờ khởi hành: 300.000 VND (*)</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Hệ số cộng điểm Flyezy Club: 2</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Thay đổi miễn phí</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Chọn ghế ngồi miễn phí</span></li><li><span style="background-color:rgb(255,255,255);color:rgb(52,64,84);">Đổi chuyến tại sân bay miễn phí</span></li></ul>', 6, 0.5, 1),
  (3, 'Economy', 168, 'img/bamboo-economy.jpg', 2, NULL, 6, 0, 1),
  (4, 'Business', 8, 'img/bamboo-business.jpg', 2, NULL, 6, 0.5, 1),
  (5, 'Economy', 162, 'img/bamboo-economy.jpg', 3, NULL, 6, 0, 1),
  (6, 'Business', 8, 'img/bamboo-business.jpg', 3, NULL, 6, 0.5, 1),
  (7, 'Hạng Phổ Thông', 162, 'img/vnairline-A321-GhePhoThong.png', 4, NULL, 6, 0, 1),
  (8, 'Hạng Thương Gia', 16, 'img/vnairline-A321-Business.png', 4, '', 6, 0.5, 1),
  (9, 'Hạng Phổ Thông', 211, 'img/vnairline-B787-GhePhoThong.png', 5, NULL, 6, 0, 1),
  (10, 'Hạng Phổ Thông Đặc Biệt', 35, 'img/vnairline-B787-GhePhoThongDacBiet.png', 5, NULL, 6, 0.3, 1),
  (11, 'Hạng Thương Gia', 28, 'img/vnairline-B787-GheThuongGia.png', 5, NULL, 6, 0.5, 1),
  (12, 'Hạng Phổ Thông', 231, 'img/vnairline-A350-GhePhoThong.png', 6, NULL, 6, 0, 1),
  (13, 'Hạng Phổ Thông Đặc Biệt', 45, 'img/vnairline-A350-GhePhoThongDacBiet.png', 6, NULL, 6, 0.3, 1),
  (14, 'Hạng Thương Gia', 29, 'img/vnairline-A350-GheThuongGia.png', 6, NULL, 6, 0.5, 1),
  (15, 'Hạng Phổ Thông', 180, 'img/vnairline-A320neo-PhoThong.png', 7, NULL, 6, 0, 1),
  (16, 'Hạng Thương Gia', 8, 'img/vnairline-A320neo-Thuong gia.png', 7, NULL, 6, 0.5, 1);
  
INSERT INTO Country (id,name)
VALUES
    (1,'Việt Nam'),
    (2,'Nhật Bản'),
    (3,'Hàn Quốc');

INSERT INTO Location (id,name, Country_id)
VALUES
    (1,'Hà Nội', 1),
    (2,'TP. Hồ Chí Minh', 1),
    (3,'Tokyo', 2),
    (4,'Osaka', 2),
    (5,'Seoul', 3),
    (6,'Busan', 3);

INSERT INTO Airport (id,name, Locationid)
VALUES
    (1,'Nội Bài International Airport', 1),
    (2,'Tân Sơn Nhất International Airport', 2),
    (3,'Narita International Airport', 3),
    (4,'Kansai International Airport', 4),
    (5,'Incheon International Airport', 5),
    (6,'Gimhae International Airport', 6);

INSERT INTO `flyezy`.`Passenger_Types` (`id`, `name`, `price`)
VALUES 
(1, 'Adult', 1),
(2, 'Children', 0.8),
(3, 'Infant', 0.5);


INSERT INTO `Flight` VALUES (1,120,1,2,1,3),(2,120,2,1,1,3),(3,360,1,3,1,3),(4,360,3,1,1,3),(5,360,2,3,1,3),(6,360,3,2,1,3),(7,300,1,4,1,2),(8,300,4,1,1,2),(9,300,2,6,1,2),(10,300,6,2,1,2);
INSERT INTO `Flight_Detail` VALUES (1,'2024-10-01','14:30:00',1200000,1,1,3),(2,'2024-10-02','15:45:00',1350000,1,2,3),(3,'2024-10-03','10:00:00',1500000,1,3,3);
INSERT INTO `Flight_Type` VALUES (1,'Outbound '),(2,'RT-Outbound'),(3,'RT-Inbound');

INSERT INTO `flyezy`.`Payment_Types` (`id`, `name`,`image`)
VALUES 
(1, 'QR Code', null),
(2, 'VNPAY',null);

INSERT INTO `flyezy`.`Order` (`id`, `code`, `contactName`, `contactPhone`, `contactEmail`, `totalPrice`, `Accounts_id`, `Payment_Types_id`, `paymentTime`, `created_at`, `Discount_id`, `Status_id`)
VALUES 
(1, 'FJA84IUTJ', 'John Doe', '0912345678', 'john.doe@example.com', 1200000, 1, 1, '2024-10-01 14:00:00', NOW(), null, 10),
(2, 'BDNA83JFK', 'Jane Smith', '0987654321', 'jane.smith@example.com', 1350000, 1, 2, '2024-10-02 15:15:00', NOW(), null, 10),
(3, 'O3MFKALSS', 'Alice Johnson', '0978123456', 'alice.johnson@example.com', 1500000, 1, 1, '2024-10-03 09:30:00', NOW(), null, 10);

INSERT INTO `flyezy`.`Ticket` (`id`, `Flight_Detail_id`, `Seat_Categoryid`, `Passenger_Typesid`, `code`, `pName`, `pSex`, `pPhoneNumber`, `pDob`, `Flight_Type_id`, `Baggagesid`, `totalPrice`, `Order_id`, `Statusid`)
VALUES 
(1, 1, 7, 1, 'A1', 'Passenger 1', 1, '0912345678', '1990-01-01', 1, NULL,0, 1, 10),
(2, 2, 8, 2, 'C2', 'Passenger 2', 1, '0987654321', '1992-05-10', 1, NULL,0, 1, 10),
(3, 2, 7, 1, 'B3', 'Passenger 3', 1, '0978123456', '1988-08-20', 1, NULL,0, 2, 10);








