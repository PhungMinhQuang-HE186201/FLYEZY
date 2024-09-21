CREATE DATABASE  IF NOT EXISTS `flyezy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `flyezy`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: flyezy
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Accounts`
--

DROP TABLE IF EXISTS `Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `Rolesid` int NOT NULL,
  `Airlineid` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAccounts201294` (`Rolesid`),
  KEY `FKAccounts898886` (`Airlineid`),
  CONSTRAINT `FKAccounts201294` FOREIGN KEY (`Rolesid`) REFERENCES `Roles` (`id`),
  CONSTRAINT `FKAccounts898886` FOREIGN KEY (`Airlineid`) REFERENCES `Airline` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accounts`
--

LOCK TABLES `Accounts` WRITE;
/*!40000 ALTER TABLE `Accounts` DISABLE KEYS */;
INSERT INTO `Accounts` VALUES (2,'Ngo Tung Duong','duongnthe186310@fpt.edu.vn','1','0862521226','null','img/avatar.jpg','2024-02-06',1,2,NULL,NULL),(3,'Ho Tran Quan','quan@gmail.com','1','0123456789','','img/avatar-2.jpg','2024-09-17',2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airline`
--

DROP TABLE IF EXISTS `Airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airline` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airline`
--

LOCK TABLES `Airline` WRITE;
/*!40000 ALTER TABLE `Airline` DISABLE KEYS */;
INSERT INTO `Airline` VALUES (1,'Empty',NULL,NULL),(2,'Vietnam Airline',NULL,NULL),(3,'Bamboo Airway',NULL,NULL),(4,'Vietjet Air',NULL,NULL);
/*!40000 ALTER TABLE `Airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Airport`
--

DROP TABLE IF EXISTS `Airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airport` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `Locationid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAirport14562` (`Locationid`),
  CONSTRAINT `FKAirport14562` FOREIGN KEY (`Locationid`) REFERENCES `Location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Airport`
--

LOCK TABLES `Airport` WRITE;
/*!40000 ALTER TABLE `Airport` DISABLE KEYS */;
/*!40000 ALTER TABLE `Airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Baggages`
--

DROP TABLE IF EXISTS `Baggages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Baggages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weight` float DEFAULT NULL,
  `price` int DEFAULT NULL,
  `Airlineid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBaggages227358` (`Airlineid`),
  CONSTRAINT `FKBaggages227358` FOREIGN KEY (`Airlineid`) REFERENCES `Airline` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Baggages`
--

LOCK TABLES `Baggages` WRITE;
/*!40000 ALTER TABLE `Baggages` DISABLE KEYS */;
/*!40000 ALTER TABLE `Baggages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Discount`
--

DROP TABLE IF EXISTS `Discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `percentage` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Discount`
--

LOCK TABLES `Discount` WRITE;
/*!40000 ALTER TABLE `Discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `Discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Feedbacks`
--

DROP TABLE IF EXISTS `Feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feedbacks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Accountsid` int NOT NULL,
  `ratedStar` int DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `Airlineid` int NOT NULL,
  `Statusid` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFeedbacks957463` (`Accountsid`),
  KEY `FKFeedbacks177109` (`Airlineid`),
  KEY `FKFeedbacks883062` (`Statusid`),
  CONSTRAINT `FKFeedbacks177109` FOREIGN KEY (`Airlineid`) REFERENCES `Airline` (`id`),
  CONSTRAINT `FKFeedbacks883062` FOREIGN KEY (`Statusid`) REFERENCES `Status` (`id`),
  CONSTRAINT `FKFeedbacks957463` FOREIGN KEY (`Accountsid`) REFERENCES `Accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedbacks`
--

LOCK TABLES `Feedbacks` WRITE;
/*!40000 ALTER TABLE `Feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `Feedbacks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight`
--

DROP TABLE IF EXISTS `Flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` int DEFAULT NULL,
  `minutes` int DEFAULT NULL,
  `departureAirportid` int NOT NULL,
  `destinationAirportid` int NOT NULL,
  `Flight_Typeid` int NOT NULL,
  `Discountid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFlight90325` (`departureAirportid`),
  KEY `FKFlight563127` (`destinationAirportid`),
  KEY `FKFlight644782` (`Flight_Typeid`),
  KEY `FKFlight225776` (`Discountid`),
  CONSTRAINT `FKFlight225776` FOREIGN KEY (`Discountid`) REFERENCES `Discount` (`id`),
  CONSTRAINT `FKFlight563127` FOREIGN KEY (`destinationAirportid`) REFERENCES `Airport` (`id`),
  CONSTRAINT `FKFlight644782` FOREIGN KEY (`Flight_Typeid`) REFERENCES `Flight_Type` (`id`),
  CONSTRAINT `FKFlight90325` FOREIGN KEY (`departureAirportid`) REFERENCES `Airport` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight`
--

LOCK TABLES `Flight` WRITE;
/*!40000 ALTER TABLE `Flight` DISABLE KEYS */;
/*!40000 ALTER TABLE `Flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight_Detail`
--

DROP TABLE IF EXISTS `Flight_Detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight_Detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `time` time(6) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `Flightid` int NOT NULL,
  `Plane_Categoryid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFlight_Det484575` (`Flightid`),
  KEY `FKFlight_Det564449` (`Plane_Categoryid`),
  CONSTRAINT `FKFlight_Det484575` FOREIGN KEY (`Flightid`) REFERENCES `Flight` (`id`),
  CONSTRAINT `FKFlight_Det564449` FOREIGN KEY (`Plane_Categoryid`) REFERENCES `Plane_Category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight_Detail`
--

LOCK TABLES `Flight_Detail` WRITE;
/*!40000 ALTER TABLE `Flight_Detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `Flight_Detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Flight_Type`
--

DROP TABLE IF EXISTS `Flight_Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight_Type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Flight_Type`
--

LOCK TABLES `Flight_Type` WRITE;
/*!40000 ALTER TABLE `Flight_Type` DISABLE KEYS */;
/*!40000 ALTER TABLE `Flight_Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `News`
--

DROP TABLE IF EXISTS `News`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `News` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `News_Categoryid` int NOT NULL,
  `Accountsid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKNews232818` (`News_Categoryid`),
  KEY `FKNews924154` (`Accountsid`),
  CONSTRAINT `FKNews232818` FOREIGN KEY (`News_Categoryid`) REFERENCES `News_Category` (`id`),
  CONSTRAINT `FKNews924154` FOREIGN KEY (`Accountsid`) REFERENCES `Accounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `News`
--

LOCK TABLES `News` WRITE;
/*!40000 ALTER TABLE `News` DISABLE KEYS */;
/*!40000 ALTER TABLE `News` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `News_Category`
--

DROP TABLE IF EXISTS `News_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `News_Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `News_Category`
--

LOCK TABLES `News_Category` WRITE;
/*!40000 ALTER TABLE `News_Category` DISABLE KEYS */;
/*!40000 ALTER TABLE `News_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Passenger_Types`
--

DROP TABLE IF EXISTS `Passenger_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Passenger_Types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Passenger_Types`
--

LOCK TABLES `Passenger_Types` WRITE;
/*!40000 ALTER TABLE `Passenger_Types` DISABLE KEYS */;
/*!40000 ALTER TABLE `Passenger_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payment_Types`
--

DROP TABLE IF EXISTS `Payment_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment_Types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payment_Types`
--

LOCK TABLES `Payment_Types` WRITE;
/*!40000 ALTER TABLE `Payment_Types` DISABLE KEYS */;
/*!40000 ALTER TABLE `Payment_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Plane_Category`
--

DROP TABLE IF EXISTS `Plane_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Plane_Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `Airlineid` int NOT NULL,
  `info` text,
  PRIMARY KEY (`id`),
  KEY `FKPlane_Cate276706` (`Airlineid`),
  CONSTRAINT `FKPlane_Cate276706` FOREIGN KEY (`Airlineid`) REFERENCES `Airline` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Plane_Category`
--

LOCK TABLES `Plane_Category` WRITE;
/*!40000 ALTER TABLE `Plane_Category` DISABLE KEYS */;
INSERT INTO `Plane_Category` VALUES (1,'Airbus A321CEO','img/Airbus A321CEO.png',3,NULL),(2,'Airbus A320NEO','img/Airbus A320NEO.png',3,NULL),(3,'Airbus A320CEO','img/Airbus A320CEO.png',3,NULL),(4,'Airbus A321','img/vnairline-AIRBUS A321.png',2,NULL),(5,'BOEING 787','img/vnairline-BOEING 787.png',2,NULL),(6,'AIRBUS A350','img/vnairline-AIRBUS A350.png',2,NULL),(7,'AIRBUS A320 NEO','img/vnairline-AIRBUS A320 NEO.png',2,NULL);
/*!40000 ALTER TABLE `Plane_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Refund`
--

DROP TABLE IF EXISTS `Refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Refund` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bank` varchar(255) DEFAULT NULL,
  `bankAccount` varchar(255) DEFAULT NULL,
  `Ticketid` int NOT NULL,
  `Statusid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKRefund25985` (`Ticketid`),
  KEY `FKRefund748756` (`Statusid`),
  CONSTRAINT `FKRefund25985` FOREIGN KEY (`Ticketid`) REFERENCES `Ticket` (`id`),
  CONSTRAINT `FKRefund748756` FOREIGN KEY (`Statusid`) REFERENCES `Status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Refund`
--

LOCK TABLES `Refund` WRITE;
/*!40000 ALTER TABLE `Refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `Refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Roles`
--

DROP TABLE IF EXISTS `Roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Roles`
--

LOCK TABLES `Roles` WRITE;
/*!40000 ALTER TABLE `Roles` DISABLE KEYS */;
INSERT INTO `Roles` VALUES (1,'Admin'),(2,'Airline Staff'),(3,'Member'),(4,'Service Staff');
/*!40000 ALTER TABLE `Roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Seat_Category`
--

DROP TABLE IF EXISTS `Seat_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Seat_Category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `numberOfSeat` int DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `Plane_Categoryid` int NOT NULL,
  `info` text,
  PRIMARY KEY (`id`),
  KEY `FKSeat_Categ529738` (`Plane_Categoryid`),
  CONSTRAINT `FKSeat_Categ529738` FOREIGN KEY (`Plane_Categoryid`) REFERENCES `Plane_Category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Seat_Category`
--

LOCK TABLES `Seat_Category` WRITE;
/*!40000 ALTER TABLE `Seat_Category` DISABLE KEYS */;
INSERT INTO `Seat_Category` VALUES (1,'Economy',184,'img/bamboo-economy.jpg',1,NULL),(2,'Business',8,'img/bamboo-business.jpg',1,NULL),(3,'Economy',168,'img/bamboo-economy.jpg',2,NULL),(4,'Business',8,'img/bamboo-business.jpg',2,NULL),(5,'Economy',162,'img/bamboo-economy.jpg',3,NULL),(6,'Business',8,'img/bamboo-business.jpg',3,NULL),(7,'Hạng Thương Gia',16,'img/vnairline-A321-Business.png',4,NULL),(8,'Hạng Phổ Thông',162,'img/vnairline-A321-GhePhoThong.png',4,NULL),(9,'Hạng Thương Gia',28,'img/vnairline-B787-GheThuongGia.png',5,NULL),(10,'Hạng Phổ Thông Đặc Biệt',35,'img/vnairline-B787-GhePhoThongDacBiet.png',5,NULL),(11,'Hạng Phổ Thông',211,'img/vnairline-B787-GhePhoThong.png',5,NULL),(12,'Hạng Thương Gia',29,'img/vnairline-A350-GheThuongGia.png',6,NULL),(13,'Hạng Phổ Thông Đặc Biệt',45,'img/vnairline-A350-GhePhoThongDacBiet.png',6,NULL),(14,'Hạng Phổ Thông',231,'img/vnairline-A350-GhePhoThong.png',6,NULL),(15,'Hạng Thương Gia',8,'img/vnairline-A320neo-Thuong gia.png',7,NULL),(16,'Hạng Phổ Thông',180,'img/vnairline-A320neo-PhoThong.png',7,NULL);
/*!40000 ALTER TABLE `Seat_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Status`
--

DROP TABLE IF EXISTS `Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Status`
--

LOCK TABLES `Status` WRITE;
/*!40000 ALTER TABLE `Status` DISABLE KEYS */;
/*!40000 ALTER TABLE `Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `Accountsid` int NOT NULL,
  `Flight_Detailid` int NOT NULL,
  `pName` varchar(255) DEFAULT NULL,
  `pSex` bit(1) DEFAULT NULL,
  `pPhoneNumber` int DEFAULT NULL,
  `Passenger_Typesid` int NOT NULL,
  `PaymentTypeid` int NOT NULL,
  `Seat_Categoryid` int NOT NULL,
  `Baggagesid` int NOT NULL,
  `paymentTime` timestamp NULL DEFAULT NULL,
  `Statusid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKTicket527556` (`Accountsid`),
  KEY `FKTicket704972` (`Flight_Detailid`),
  KEY `FKTicket339557` (`Passenger_Typesid`),
  KEY `FKTicket339803` (`PaymentTypeid`),
  KEY `FKTicket999927` (`Baggagesid`),
  KEY `FKTicket721068` (`Seat_Categoryid`),
  KEY `FKTicket601957` (`Statusid`),
  CONSTRAINT `FKTicket339557` FOREIGN KEY (`Passenger_Typesid`) REFERENCES `Passenger_Types` (`id`),
  CONSTRAINT `FKTicket339803` FOREIGN KEY (`PaymentTypeid`) REFERENCES `Payment_Types` (`id`),
  CONSTRAINT `FKTicket527556` FOREIGN KEY (`Accountsid`) REFERENCES `Accounts` (`id`),
  CONSTRAINT `FKTicket601957` FOREIGN KEY (`Statusid`) REFERENCES `Status` (`id`),
  CONSTRAINT `FKTicket704972` FOREIGN KEY (`Flight_Detailid`) REFERENCES `Flight_Detail` (`id`),
  CONSTRAINT `FKTicket721068` FOREIGN KEY (`Seat_Categoryid`) REFERENCES `Seat_Category` (`id`),
  CONSTRAINT `FKTicket999927` FOREIGN KEY (`Baggagesid`) REFERENCES `Baggages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ticket`
--

LOCK TABLES `Ticket` WRITE;
/*!40000 ALTER TABLE `Ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `Ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'flyezy'
--

--
-- Dumping routines for database 'flyezy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-19 17:21:50
