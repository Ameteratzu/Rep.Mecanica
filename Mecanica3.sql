-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: mecanica2
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `automoviles`
--

DROP TABLE IF EXISTS `automoviles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automoviles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int DEFAULT NULL,
  `placa` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `marca` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `modelo` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `año` int DEFAULT NULL,
  `color` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `automoviles_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automoviles`
--

LOCK TABLES `automoviles` WRITE;
/*!40000 ALTER TABLE `automoviles` DISABLE KEYS */;
INSERT INTO `automoviles` VALUES (1,1,'ABC123','Toyota','Corolla',2018,'Rojo',1),(2,2,'DEF456','Hyundai','Accent',2017,'Negro',1),(3,3,'GHI789','Chevrolet','Sail',2020,'Blanco',1),(4,4,'JKL012','Nissan','Versa',2019,'Gris',1),(5,5,'MNO345','Kia','Rio',2016,'Azul',1),(6,6,'PQR678','Mazda','3',2015,'Plata',1),(7,7,'STU901','Volkswagen','Gol',2021,'Rojo',1),(8,8,'VWX234','Renault','Logan',2022,'Negro',1),(9,9,'YZA567','Honda','Civic',2018,'Blanco',1),(10,10,'BCD890','Suzuki','Swift',2019,'Verde',1),(11,11,'EFG123','Toyota','Yaris',2020,'Celeste',1),(12,12,'HIJ456','Chevrolet','Aveo',2017,'Gris',1),(13,13,'KLM789','Hyundai','Elantra',2016,'Azul',1),(14,14,'NOP012','Nissan','Sentra',2015,'Negro',1),(15,15,'QRS345','Kia','Cerato',2018,'Rojo',1),(16,16,'TUV678','Mazda','6',2019,'Plomo',1),(17,17,'WXY901','Volkswagen','Jetta',2021,'Blanco',1),(18,18,'ZAB234','Renault','Sandero',2022,'Verde',1),(19,19,'CDE567','Honda','Fit',2017,'Amarillo',1),(20,20,'FGH890','Suzuki','Baleno',2018,'Negro',1),(21,21,'IJK123','Toyota','Hilux',2020,'Plata',1),(22,22,'LMN456','Chevrolet','Tracker',2021,'Azul',1),(23,23,'OPQ789','Hyundai','Tucson',2022,'Rojo',1),(24,24,'RST012','Nissan','X-Trail',2019,'Negro',1),(25,25,'UVW345','Kia','Sportage',2020,'Blanco',1),(26,26,'XYZ678','Mazda','CX-5',2021,'Gris',1),(27,27,'ABD111','Volkswagen','Tiguan',2022,'Negro',1),(28,28,'CDE222','Renault','Duster',2021,'Rojo',1),(29,29,'EFG333','Honda','HR-V',2018,'Blanco',1),(30,30,'HIJ444','Suzuki','Vitara',2019,'Verde',1),(31,31,'KLM555','Toyota','Avanza',2017,'Gris',1),(32,32,'NOP666','Chevrolet','Spin',2020,'Plata',1),(33,33,'QRS777','Hyundai','Creta',2019,'Azul',1),(34,34,'TUV888','Nissan','Kicks',2022,'Rojo',1),(35,35,'WXY999','Kia','Seltos',2021,'Negro',1),(36,36,'ZAB000','Mazda','CX-3',2020,'Blanco',1),(37,37,'CDE111','Volkswagen','Polo',2016,'Verde',1),(38,38,'FGH222','Renault','Clio',2015,'Gris',1),(39,39,'IJK333','Honda','City',2018,'Plata',1),(40,40,'LMN444','Suzuki','Celerio',2019,'Negro',1),(41,41,'OPQ555','Toyota','Fortuner',2021,'Rojo',1),(42,42,'RST666','Chevrolet','Captiva',2020,'Azul',1),(43,43,'UVW777','Hyundai','Santa Fe',2022,'Gris',1),(44,44,'XYZ888','Nissan','Murano',2019,'Blanco',1),(45,45,'ABD999','Kia','Sorento',2021,'Negro',1),(46,46,'CDE000','Mazda','CX-9',2020,'Plata',1),(47,47,'EFG111','Volkswagen','Passat',2017,'Azul',1),(48,48,'HIJ222','Renault','Megane',2018,'Rojo',1),(49,NULL,'KLM333','Honda','Odyssey',2020,'Gris',1),(50,50,'NOP444','Suzuki','Ertiga',2021,'Blanco',1);
/*!40000 ALTER TABLE `automoviles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'repuestos',1),(2,'accesorios',1),(3,'lubricantes',1),(4,'herramientas',1),(5,'neumáticos',1);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `tipoDocumento` varchar(20) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DNI',
  `correo` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ubigeo_id` int NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `celular` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `tipo_documento` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ubigeo_id` (`ubigeo_id`),
  CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`ubigeo_id`) REFERENCES `ubigeos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'70000001','Luis','Vargas','DNI',NULL,1,'Av. Arequipa 123','987654321',1,NULL),(2,'70000002','Ana','Pérez','DNI',NULL,2,'Jr. Libertad 456','987654322',1,NULL),(3,'70000003','Carlos','Ramírez','DNI',NULL,3,'Av. Metropolitana 789','987654323',1,NULL),(4,'70000004','María','Gonzales','DNI',NULL,4,'Calle Italia 234','987654324',1,NULL),(5,'70000005','José','López','DNI',NULL,5,'Av. Brasil 567','987654325',1,NULL),(6,'70000006','Lucía','Torres','DNI',NULL,6,'Av. Túpac Amaru 890','987654326',1,NULL),(7,'70000007','Javier','Morales','DNI',NULL,7,'Jr. Los Álamos 101','987654327',1,NULL),(8,'70000008','Diana','Fernández','DNI',NULL,8,'Av. Huaylas 202','987654328',1,NULL),(9,'70000009','Renato','Sánchez','DNI',NULL,9,'Calle Sol Naciente 303','987654329',1,NULL),(10,'70000010','Sofía','Martínez','DNI',NULL,10,'Av. Universitaria 404','987654330',1,NULL),(11,'70000011','Pedro','Salas','DNI',NULL,11,'Jr. César Vallejo 505','987654331',1,NULL),(12,'70000012','Carmen','Cruz','DNI',NULL,12,'Av. Tomás Valle 606','987654332',1,NULL),(13,'70000013','Héctor','Navarro','DNI',NULL,13,'Calle Tarata 707','987654333',1,NULL),(14,'70000014','Vanessa','Reyes','DNI',NULL,14,'Av. Flora Tristán 808','987654334',1,NULL),(15,'70000015','Jorge','Ibáñez','DNI',NULL,15,'Jr. Gamarra 909','987654335',1,NULL),(16,'70000016','Natalia','Pacheco','DNI',NULL,16,'Av. Canevaro 111','987654336',1,NULL),(17,'70000017','Diego','Ortega','DNI',NULL,17,'Calle Los Jazmines 222','987654337',1,NULL),(18,'70000018','Andrea','Luna','DNI',NULL,18,'Av. Wiesse 333','987654338',1,NULL),(19,'70000019','Martín','Camacho','DNI',NULL,19,'Jr. Los Olivos 444','987654339',1,NULL),(20,'70000020','Rosa','Aguilar','DNI',NULL,20,'Av. Brasil 555','987654340',1,NULL),(21,'70000021','Oscar','Delgado','DNI',NULL,21,'Av. Larco 666','987654341',1,NULL),(22,'70000022','Julia','Montoya','DNI',NULL,22,'Calle Primavera 777','987654342',1,NULL),(23,'70000023','Ángel','Soto','DNI',NULL,23,'Av. Malecon 888','987654343',1,NULL),(24,'70000024','Claudia','Mejía','DNI',NULL,24,'Jr. Zarumilla 999','987654344',1,NULL),(25,'70000025','Fernando','Gamarra','DNI',NULL,25,'Av. Alcázar 1110','987654345',1,NULL),(26,'70000026','Tatiana','Rosales','DNI',NULL,26,'Calle 2 de Mayo 1212','987654346',1,NULL),(27,'70000027','Iván','Villanueva','DNI',NULL,27,'Jr. América 1313','987654347',1,NULL),(28,'70000028','Camila','Rivas','DNI',NULL,28,'Av. Colonial 1414','987654348',1,NULL),(29,'70000029','Cristina','Becerra','DNI',NULL,29,'Calle San Martín 1515','987654349',1,NULL),(30,'70000030','Esteban','Ruiz','DNI',NULL,30,'Jr. Salaverry 1616','987654350',1,NULL),(31,'70000031','Paola','Zambrano','DNI',NULL,31,'Av. Néstor Gambetta 1717','987654351',1,NULL),(32,'70000032','Tomás','Cabrera','DNI',NULL,32,'Av. Mi Perú 1818','987654352',1,NULL),(33,'70000033','Gabriela','Mendoza','DNI',NULL,5,'Av. Venezuela 1919','987654353',1,NULL),(34,'70000034','Andrés','Silva','DNI',NULL,8,'Jr. Sucre 2020','987654354',1,NULL),(35,'70000035','Melissa','Quispe','DNI',NULL,12,'Calle Real 2121','987654355',1,NULL),(36,'70000036','Alan','Castañeda','DNI',NULL,15,'Av. Javier Prado 2222','987654356',1,NULL),(37,'70000037','Fiorella','León','DNI',NULL,3,'Calle Primavera 2323','987654357',1,NULL),(38,'70000038','Rodrigo','Vargas','DNI',NULL,9,'Av. Las Torres 2424','987654358',1,NULL),(39,'70000039','Patricia','Barreto','DNI',NULL,14,'Jr. Arica 2525','987654359',1,NULL),(40,'70000040','Kevin','Alfaro','DNI',NULL,19,'Calle 28 de Julio 2626','987654360',1,NULL),(41,'70000041','Mónica','Espinoza','DNI',NULL,21,'Av. Grau 2727','987654361',1,NULL),(42,'70000042','Enrique','Solís','DNI',NULL,11,'Jr. Lima 2828','987654362',1,NULL),(43,'70000043','Lorena','Velásquez','DNI',NULL,6,'Av. Trapiche 2929','987654363',1,NULL),(44,'70000044','Álvaro','Cornejo','DNI',NULL,13,'Jr. Puno 3030','987654364',1,NULL),(45,'70000045','Daniela','Del Carpio','DNI',NULL,7,'Av. Las Palmeras 3131','987654365',1,NULL),(46,'70000046','Bruno','Galván','DNI',NULL,18,'Jr. José Olaya 3232','987654366',1,NULL),(47,'70000047','Luisa','Gómez','DNI',NULL,20,'Av. Ejército 3333','987654367',1,NULL),(48,'70000048','César','Ríos','DNI',NULL,22,'Calle Comercio 3434','987654368',1,NULL),(50,'70000050','Sebastián','Cáceres','DNI',NULL,27,'Jr. Talara 3636','9876543444',1,NULL),(55,'74372087','Amet Marcelo','Quispe Espichan','DNI','quispeamet2@gmail.com',27,'C. las azucenas','931262732',1,NULL),(84,'47897897','Juan','Sandoval','DNI','perez@gmail.com',9,'Calle los Jazminez156','9876543444',1,NULL),(85,'11111112','Juan','Sandoval','DNI','perez@gmail.com',11,'Calle los Jazminez156','9876543444',1,NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprobante_detalle`
--

DROP TABLE IF EXISTS `comprobante_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprobante_detalle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comprobante_id` int NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `producto_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comprobante_id` (`comprobante_id`),
  KEY `fk_producto` (`producto_id`),
  CONSTRAINT `comprobante_detalle_ibfk_1` FOREIGN KEY (`comprobante_id`) REFERENCES `comprobantes` (`id`),
  CONSTRAINT `fk_producto` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprobante_detalle`
--

LOCK TABLES `comprobante_detalle` WRITE;
/*!40000 ALTER TABLE `comprobante_detalle` DISABLE KEYS */;
INSERT INTO `comprobante_detalle` VALUES (1,1,'Cambio de aceite',1,35.00,35.00,NULL),(2,1,'Filtro de aceite',1,15.00,15.00,NULL),(3,1,'Limpieza básica',1,10.00,10.00,NULL),(4,2,'Servicio de frenos',1,60.00,60.00,NULL),(5,2,'Pastillas de freno',1,40.00,40.00,NULL),(6,3,'Revisión general',1,70.00,70.00,NULL),(7,3,'Alineamiento y balanceo',1,50.00,50.00,NULL),(8,3,'Cambio de batería',1,85.50,85.50,NULL),(9,4,'Cambio de bujías',4,25.00,100.00,NULL),(10,4,'Ajuste motor',1,50.00,50.00,NULL),(11,5,'Rotación de neumáticos',1,30.00,30.00,NULL),(12,5,'Lavado completo',1,50.00,50.00,NULL),(13,6,'Reparación de luces',2,35.00,70.00,NULL),(14,6,'Cambio de correa',1,60.00,60.00,NULL),(15,6,'Revisión electrónica',1,82.00,82.00,NULL),(16,7,'Cambio de filtro aire',1,35.00,35.00,NULL),(17,7,'Limpieza de inyectores',1,24.90,24.90,NULL),(18,8,'Servicio de alineamiento',1,60.00,60.00,NULL),(19,8,'Reemplazo aceite',1,38.50,38.50,NULL),(20,9,'Cambio de llantas',2,160.00,320.00,NULL),(21,10,'Diagnóstico completo',1,100.00,100.00,NULL),(22,10,'Lavado básico',1,35.75,35.75,NULL),(23,11,'Cambio de aceite',1,70.00,70.00,NULL),(24,11,'Filtro de aire',2,70.00,140.00,NULL),(25,12,'Lavado completo',1,80.00,80.00,NULL),(26,12,'Desinfección',1,15.00,15.00,NULL),(27,13,'Revisión frenos',1,30.00,30.00,NULL),(28,13,'Rotación llantas',1,10.00,10.00,NULL),(29,14,'Afinamiento motor',1,150.00,150.00,NULL),(30,14,'Bujías',2,15.00,30.00,NULL),(31,15,'Líquido de frenos',1,45.00,45.00,NULL),(32,15,'Lavado básico',1,30.00,30.00,NULL),(33,16,'Pulido faros',1,37.50,37.50,NULL),(34,16,'Desodorización',1,30.00,30.00,NULL),(35,17,'Cambio neumático',1,90.00,90.00,NULL),(36,17,'Lavado express',1,12.00,12.00,NULL),(37,18,'Balanceo',2,67.50,135.00,NULL),(38,19,'Lavado motor',1,60.00,60.00,NULL),(39,19,'Engrase',1,21.00,21.00,NULL),(40,20,'Desinfección',2,85.00,170.00,NULL),(41,21,'Lavado express',1,30.00,30.00,NULL),(42,21,'Pulido',1,18.00,18.00,NULL),(43,22,'Aceite sintético',1,90.00,90.00,NULL),(44,22,'Filtro aceite',1,35.00,35.00,NULL),(45,23,'Lavado básico',2,44.00,88.00,NULL),(46,24,'Pulido',1,37.50,37.50,NULL),(47,25,'Cambio bujía',1,85.00,85.00,NULL),(48,25,'Lavado',1,110.00,110.00,NULL),(49,26,'Lavado motor',2,30.00,60.00,NULL),(50,27,'Líquido refrigerante',3,45.00,135.00,NULL),(51,28,'Pulido',2,28.00,56.00,NULL),(52,29,'Diagnóstico',1,100.00,100.00,NULL),(53,29,'Cambio filtro',3,30.00,90.00,NULL),(54,30,'Lavado',2,40.00,80.00,NULL),(55,31,'Lavado tapiz',2,51.00,102.00,NULL),(56,32,'Balanceo',2,66.00,132.00,NULL),(57,33,'Lavado básico',2,44.00,88.00,NULL),(58,34,'Cambio correa',1,120.00,120.00,NULL),(59,34,'Lavado',1,30.00,30.00,NULL),(60,35,'Alineación',1,70.00,70.00,NULL),(61,36,'Rotación llantas',2,20.00,40.00,NULL),(62,37,'Aceite mineral',1,65.00,65.00,NULL),(63,37,'Filtro aire',1,50.00,50.00,NULL),(64,38,'Cambio aceite',1,45.00,45.00,NULL),(65,38,'Lavado',1,54.00,54.00,NULL),(66,39,'Afinamiento',1,150.00,150.00,NULL),(67,40,'Pulido',1,27.50,27.50,NULL),(68,40,'Lavado',2,20.00,40.00,NULL),(69,41,'Lavado completo',2,56.00,112.00,NULL),(70,49,'SILLAS',20,19.99,399.80,NULL),(71,50,'SILLAS',22,22.00,484.00,NULL),(72,51,'cera',1111,1111.00,1234321.00,NULL),(73,52,'mesas',1,2.00,2.00,NULL);
/*!40000 ALTER TABLE `comprobante_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comprobantes`
--

DROP TABLE IF EXISTS `comprobantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprobantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serie` varchar(4) COLLATE utf8mb4_general_ci NOT NULL,
  `numero` int NOT NULL,
  `fecha_emision` datetime NOT NULL,
  `cliente_id` int NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `igv` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `forma_pago` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `observaciones` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `orden_id` int DEFAULT NULL,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  CONSTRAINT `comprobantes_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comprobantes`
--

LOCK TABLES `comprobantes` WRITE;
/*!40000 ALTER TABLE `comprobantes` DISABLE KEYS */;
INSERT INTO `comprobantes` VALUES (1,'B001',1,'2024-05-18 10:15:00',1,59.00,9.00,50.00,'Efectivo','Boleta de prueba',1,'2025-05-16 03:03:27'),(2,'B001',2,'2024-05-18 10:30:00',2,100.00,15.25,84.75,'Tarjeta','',2,'2025-05-16 03:03:27'),(3,'B001',3,'2024-05-18 11:00:00',3,205.50,31.50,174.00,'Yape','Servicio completo',3,'2025-05-16 03:03:27'),(4,'B001',4,'2024-05-18 12:00:00',4,150.00,22.88,127.12,'Efectivo','',4,'2025-05-16 03:05:55'),(5,'B001',5,'2024-05-19 09:30:00',2,80.00,12.20,67.80,'Tarjeta','Pago parcial',5,'2025-05-16 03:05:55'),(6,'B001',6,'2024-05-20 16:45:00',1,212.00,32.37,179.63,'Transferencia','',6,'2025-05-16 03:05:55'),(7,'B001',7,'2024-05-21 08:10:00',5,59.90,9.16,50.74,'Efectivo','',7,'2025-05-16 03:05:55'),(8,'B001',8,'2024-05-21 12:50:00',3,98.50,15.08,83.42,'Yape','Promoción',8,'2025-05-16 03:05:55'),(9,'B001',9,'2024-05-22 13:20:00',6,320.00,48.90,271.10,'Efectivo','',9,'2025-05-16 03:05:55'),(10,'B001',10,'2024-05-22 18:30:00',2,135.75,20.74,115.01,'Tarjeta','',10,'2025-05-16 03:05:55'),(11,'B001',11,'2024-05-23 10:25:00',1,247.80,37.80,210.00,'Efectivo','Venta mayorista',11,'2025-05-16 04:03:14'),(12,'B001',12,'2024-05-23 11:40:00',2,112.10,17.10,95.00,'Yape','',12,'2025-05-16 04:03:14'),(13,'B001',13,'2024-05-23 13:55:00',3,47.20,7.20,40.00,'Tarjeta','',13,'2025-05-16 04:03:14'),(14,'B001',14,'2024-05-23 14:30:00',4,212.40,32.40,180.00,'Transferencia','Pago por repuestos',14,'2025-05-16 04:03:14'),(15,'B001',15,'2024-05-23 15:15:00',5,88.50,13.50,75.00,'Efectivo','',15,'2025-05-16 04:03:14'),(16,'B001',16,'2024-05-23 16:10:00',6,79.65,12.15,67.50,'Tarjeta','Incluye lavado',16,'2025-05-16 04:03:14'),(17,'B001',17,'2024-05-23 16:55:00',7,120.36,18.36,102.00,'Efectivo','',17,'2025-05-16 04:03:14'),(18,'B001',18,'2024-05-23 17:40:00',8,159.30,24.30,135.00,'Efectivo','',18,'2025-05-16 04:03:14'),(19,'B001',19,'2024-05-23 18:20:00',9,95.58,14.58,81.00,'Yape','',19,'2025-05-16 04:03:14'),(20,'B001',20,'2024-05-23 19:00:00',10,200.60,30.60,170.00,'Tarjeta','Promoción del día',20,'2025-05-16 04:03:14'),(21,'B001',21,'2024-05-24 08:35:00',3,56.64,8.64,48.00,'Transferencia','',21,'2025-05-16 04:03:14'),(22,'B001',22,'2024-05-24 09:10:00',8,147.50,22.50,125.00,'Efectivo','Cliente frecuente',22,'2025-05-16 04:03:14'),(23,'B001',23,'2024-05-24 09:55:00',7,103.84,15.84,88.00,'Efectivo','',23,'2025-05-16 04:03:14'),(24,'B001',24,'2024-05-24 10:45:00',2,44.25,6.75,37.50,'Yape','',24,'2025-05-16 04:03:14'),(25,'B001',25,'2024-05-24 11:30:00',1,230.10,35.10,195.00,'Tarjeta','',25,'2025-05-16 04:03:14'),(26,'B001',26,'2024-05-24 12:05:00',6,70.80,10.80,60.00,'Transferencia','',26,'2025-05-16 04:03:14'),(27,'B001',27,'2024-05-24 12:45:00',9,159.30,24.30,135.00,'Efectivo','Venta con descuento',27,'2025-05-16 04:03:14'),(28,'B001',28,'2024-05-24 13:15:00',8,66.08,10.08,56.00,'Yape','',28,'2025-05-16 04:03:14'),(29,'B001',29,'2024-05-24 13:55:00',4,224.20,34.20,190.00,'Tarjeta','',29,'2025-05-16 04:03:14'),(30,'B001',30,'2024-05-24 14:30:00',5,94.40,14.40,80.00,'Efectivo','Pago rápido',30,'2025-05-16 04:03:14'),(31,'B001',31,'2024-05-24 15:10:00',7,120.36,18.36,102.00,'Tarjeta','',31,'2025-05-16 04:03:14'),(32,'B001',32,'2024-05-24 15:40:00',10,155.76,23.76,132.00,'Transferencia','',32,'2025-05-16 04:03:14'),(33,'B001',33,'2024-05-24 16:15:00',3,103.84,15.84,88.00,'Efectivo','',33,'2025-05-16 04:03:14'),(34,'B001',34,'2024-05-24 16:55:00',8,177.00,27.00,150.00,'Tarjeta','',34,'2025-05-16 04:03:14'),(35,'B001',35,'2024-05-24 17:25:00',5,82.60,12.60,70.00,'Yape','',35,'2025-05-16 04:03:14'),(36,'B001',36,'2024-05-24 18:00:00',4,47.20,7.20,40.00,'Efectivo','',36,'2025-05-16 04:03:14'),(37,'B001',37,'2024-05-24 18:35:00',9,135.70,20.70,115.00,'Efectivo','',37,'2025-05-16 04:03:14'),(38,'B001',38,'2024-05-24 19:05:00',6,116.82,17.82,99.00,'Tarjeta','',38,'2025-05-16 04:03:14'),(39,'B001',39,'2024-05-24 19:45:00',7,212.40,32.40,180.00,'Yape','',39,'2025-05-16 04:03:14'),(40,'B001',40,'2024-05-24 20:20:00',8,79.65,12.15,67.50,'Transferencia','',40,'2025-05-16 04:03:14'),(41,'B001',41,'2024-05-24 20:50:00',1,132.16,20.16,112.00,'Efectivo','Venta nocturna',41,'2025-05-16 04:03:14'),(44,'B001',42,'2025-05-16 10:28:37',1,0.00,0.00,0.00,'Efectivo','',NULL,'2025-05-16 05:28:37'),(45,'B001',43,'2025-05-16 10:30:58',55,0.00,0.00,0.00,'Efectivo','',NULL,'2025-05-16 05:30:58'),(46,'B001',44,'2025-05-16 00:00:00',36,0.00,0.00,0.00,'Tarjeta','amet',NULL,'2025-05-16 05:40:59'),(47,'B001',45,'2025-05-16 00:00:00',55,0.00,0.00,0.00,'Tarjeta','amet',NULL,'2025-05-16 05:41:17'),(48,'B001',46,'2025-05-16 00:00:00',55,0.00,0.00,0.00,'Plin','amet',NULL,'2025-05-16 05:41:45'),(49,'B001',47,'2025-05-16 00:00:00',55,399.80,60.99,338.81,'Efectivo','amet',NULL,'2025-05-16 05:45:06'),(50,'B001',48,'2025-05-16 00:00:00',55,484.00,73.83,410.17,'Transferencia','amet',NULL,'2025-05-16 05:56:44'),(51,'B001',49,'2025-05-16 00:00:00',55,1234321.00,188286.25,1046034.75,'Yape','amet',NULL,'2025-05-16 06:26:27'),(52,'B001',50,'2025-05-16 00:00:00',55,2.00,0.31,1.69,'Tarjeta','amet',NULL,'2025-05-16 11:45:01');
/*!40000 ALTER TABLE `comprobantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egresos`
--

DROP TABLE IF EXISTS `egresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egresos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `referencia` varchar(100) NOT NULL,
  `guia` varchar(100) NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `observacion` varchar(300) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `egresos_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egresos`
--

LOCK TABLES `egresos` WRITE;
/*!40000 ALTER TABLE `egresos` DISABLE KEYS */;
/*!40000 ALTER TABLE `egresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `egresos_productos`
--

DROP TABLE IF EXISTS `egresos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `egresos_productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `egreso_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `costo` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `egreso_id` (`egreso_id`),
  CONSTRAINT `egresos_productos_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `egresos_productos_ibfk_2` FOREIGN KEY (`egreso_id`) REFERENCES `egresos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `egresos_productos`
--

LOCK TABLES `egresos_productos` WRITE;
/*!40000 ALTER TABLE `egresos_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `egresos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_orden`
--

DROP TABLE IF EXISTS `estado_orden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_orden` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estado_orden` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_orden`
--

LOCK TABLES `estado_orden` WRITE;
/*!40000 ALTER TABLE `estado_orden` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_orden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadosordenes`
--

DROP TABLE IF EXISTS `estadosordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadosordenes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `estado_orden` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadosordenes`
--

LOCK TABLES `estadosordenes` WRITE;
/*!40000 ALTER TABLE `estadosordenes` DISABLE KEYS */;
INSERT INTO `estadosordenes` VALUES (1,'Pendiente',1),(2,'En curso',1),(3,'Finalizado',1),(4,'Cancelado',1);
/*!40000 ALTER TABLE `estadosordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos`
--

DROP TABLE IF EXISTS `ingresos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `referencia` varchar(100) NOT NULL,
  `guia` varchar(100) NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `observacion` varchar(300) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `ingresos_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresos`
--

LOCK TABLES `ingresos` WRITE;
/*!40000 ALTER TABLE `ingresos` DISABLE KEYS */;
INSERT INTO `ingresos` VALUES (1,'REF001','GUIA001','Compra de herramientas','2025-06-05',1,1000.00,'Primera compra',1),(2,'REF002','GUIA002','Compra de repuestos','2025-06-05',2,1500.00,'Segunda compra',1),(3,'REF003','GUIA003','Compra de lubricantes','2025-06-05',1,800.00,'Tercera compra',1),(4,'F001-00001515','GUI-0000003','COMPRA','2025-06-08',1,0.00,'.',1),(5,'F001-00001516','GUI-0000004','COMPRA','2025-06-08',2,0.00,'.',1),(6,'F001-00001517','GUI-0000005','COMPRA','2025-06-08',2,0.00,'.',1),(7,'F001-00001518','GUI-0000006','COMPRA','2025-06-08',1,0.00,'.',1),(11,'F001-00001520','GUI-0000008','COMPRA','2025-06-08',2,1650.00,'.',0),(12,'F001-00001521','GUI-0000009','COMPRA','2025-06-08',1,300.00,'.',1),(13,'F001-00001522','GUI-00000010','COMPRA','2025-06-08',1,275.00,'.',1),(14,'F001-00001523','GUI-00000011','COMPRA','2025-06-08',1,455.00,'.',0),(15,'F001-00001524','GUI-00000012','COMPRA','2025-06-08',2,90.00,'.',1),(16,'F001-00001525','GUI-00000013','COMPRA','2025-06-08',1,500.00,'.',1),(17,'F001-00001527','GUI-00000015','COMPRA','2025-06-08',1,150.00,'.',1),(18,'F001-00001528','GUI-00000016','COMPRA','2025-06-08',2,80.00,'.',0),(19,'F001-00001528','I001-00000001','COMPRA','2025-06-08',2,60.00,'.',1),(20,'F001-00001522','I001-00000002','COMPRA','2025-06-08',1,100.00,'.',1),(21,'F001-00001521','I001-00000003','COMPRA','2025-06-08',1,130.00,'.',1),(22,'F001-00001522','I001-00000004','COMPRA','2025-06-08',2,150.00,'.',1),(23,'F001-00001523','I001-00000005','COMPRA','2025-06-10',2,114.00,'.',0);
/*!40000 ALTER TABLE `ingresos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingresos_productos`
--

DROP TABLE IF EXISTS `ingresos_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresos_productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ingreso_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `costo` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `ingreso_id` (`ingreso_id`),
  CONSTRAINT `ingresos_productos_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `ingresos_productos_ibfk_2` FOREIGN KEY (`ingreso_id`) REFERENCES `ingresos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresos_productos`
--

LOCK TABLES `ingresos_productos` WRITE;
/*!40000 ALTER TABLE `ingresos_productos` DISABLE KEYS */;
INSERT INTO `ingresos_productos` VALUES (1,1,1,10,20.00,200.00),(2,1,2,5,30.00,150.00),(3,1,3,8,25.00,200.00),(4,1,4,10,45.00,450.00),(5,11,4,150,10.00,1500.00),(6,11,2,15,10.00,150.00),(7,12,8,25,12.00,300.00),(8,13,54,5,55.00,275.00),(9,14,1,15,12.00,180.00),(10,14,2,25,11.00,275.00),(11,15,1,10,9.00,90.00),(12,16,1,50,10.00,500.00),(13,17,2,30,5.00,150.00),(14,18,1,10,8.00,80.00),(15,19,3,4,15.00,60.00),(16,20,2,10,10.00,100.00),(17,21,8,13,10.00,130.00),(18,22,30,10,15.00,150.00),(19,23,15,3,9.00,27.00),(20,23,19,3,29.00,87.00);
/*!40000 ALTER TABLE `ingresos_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `total_ingresos` int DEFAULT '0',
  `total_egresos` int DEFAULT '0',
  `stock` int GENERATED ALWAYS AS ((`total_ingresos` - `total_egresos`)) STORED,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` (`id`, `producto_id`, `total_ingresos`, `total_egresos`) VALUES (1,1,70,0),(2,2,45,0),(3,3,12,0),(4,4,10,0),(5,8,38,0),(6,54,5,0),(7,5,0,0),(8,6,0,0),(9,7,0,0),(10,9,0,0),(11,10,0,0),(12,11,0,0),(13,12,0,0),(14,13,0,0),(15,14,0,0),(16,15,0,0),(17,16,0,0),(18,17,0,0),(19,18,0,0),(20,19,0,0),(21,20,0,0),(22,21,0,0),(23,22,0,0),(24,23,0,0),(25,24,0,0),(26,25,0,0),(27,26,0,0),(28,27,0,0),(29,28,0,0),(30,29,0,0),(31,30,10,0),(32,31,0,0),(33,32,0,0),(34,33,0,0),(35,34,0,0),(36,35,0,0),(37,36,0,0),(38,37,0,0),(39,38,0,0),(40,39,0,0),(41,40,0,0),(42,41,0,0),(43,42,0,0),(44,43,0,0),(45,44,0,0),(46,45,0,0),(47,46,0,0),(48,47,0,0),(49,48,0,0),(50,49,0,0),(51,50,0,0),(52,55,0,0),(53,56,0,0),(54,57,0,0),(55,59,0,0);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `accion` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_producto`
--

DROP TABLE IF EXISTS `orden_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orden_producto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `orden_producto_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `orden_producto_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_producto`
--

LOCK TABLES `orden_producto` WRITE;
/*!40000 ALTER TABLE `orden_producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orden_servicio`
--

DROP TABLE IF EXISTS `orden_servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orden_servicio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int NOT NULL,
  `servicio_id` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `orden_servicio_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `orden_servicio_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orden_servicio`
--

LOCK TABLES `orden_servicio` WRITE;
/*!40000 ALTER TABLE `orden_servicio` DISABLE KEYS */;
/*!40000 ALTER TABLE `orden_servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes`
--

DROP TABLE IF EXISTS `ordenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cliente_id` int NOT NULL,
  `fecha` datetime NOT NULL,
  `numero` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `usuario_id` int NOT NULL,
  `automovil_id` int NOT NULL,
  `descuento` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `estado_orden_id` int NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `estado` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `automovil_id` (`automovil_id`),
  KEY `estado_orden_id` (`estado_orden_id`),
  CONSTRAINT `ordenes_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `ordenes_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `ordenes_ibfk_3` FOREIGN KEY (`automovil_id`) REFERENCES `automoviles` (`id`),
  CONSTRAINT `ordenes_ibfk_4` FOREIGN KEY (`estado_orden_id`) REFERENCES `estadosordenes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes`
--

LOCK TABLES `ordenes` WRITE;
/*!40000 ALTER TABLE `ordenes` DISABLE KEYS */;
INSERT INTO `ordenes` VALUES (1,1,'2025-05-01 10:00:00','ORD-0001',1,1,10.00,240.00,1,1,'Pendiente'),(2,2,'2025-05-02 11:30:00','ORD-0002',2,2,0.00,380.50,3,1,'En proceso');
/*!40000 ALTER TABLE `ordenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_productos`
--

DROP TABLE IF EXISTS `ordenes_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `ordenes_productos_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `ordenes_productos_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_productos`
--

LOCK TABLES `ordenes_productos` WRITE;
/*!40000 ALTER TABLE `ordenes_productos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenes_servicios`
--

DROP TABLE IF EXISTS `ordenes_servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenes_servicios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orden_id` int NOT NULL,
  `servicio_id` int NOT NULL,
  `cantidad` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `ordenes_servicios_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `ordenes_servicios_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenes_servicios`
--

LOCK TABLES `ordenes_servicios` WRITE;
/*!40000 ALTER TABLE `ordenes_servicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenes_servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenesdetallesproductos`
--

DROP TABLE IF EXISTS `ordenesdetallesproductos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenesdetallesproductos` (
  `id` int NOT NULL,
  `orden_id` int NOT NULL,
  `producto_id` int NOT NULL,
  `cantidad` int NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `producto_id` (`producto_id`),
  CONSTRAINT `ordenesdetallesproductos_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `ordenesdetallesproductos_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenesdetallesproductos`
--

LOCK TABLES `ordenesdetallesproductos` WRITE;
/*!40000 ALTER TABLE `ordenesdetallesproductos` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenesdetallesproductos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenesdetallesservicios`
--

DROP TABLE IF EXISTS `ordenesdetallesservicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordenesdetallesservicios` (
  `id` int NOT NULL,
  `orden_id` int NOT NULL,
  `servicio_id` int NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `orden_id` (`orden_id`),
  KEY `servicio_id` (`servicio_id`),
  CONSTRAINT `ordenesdetallesservicios_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`),
  CONSTRAINT `ordenesdetallesservicios_ibfk_2` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenesdetallesservicios`
--

LOCK TABLES `ordenesdetallesservicios` WRITE;
/*!40000 ALTER TABLE `ordenesdetallesservicios` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenesdetallesservicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombres` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `correo` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `rol_id` int NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'10000001','Carlos','García','carlos.garcia1@mail.com',1,1),(2,'10000002','María','López','maria.lopez2@mail.com',2,1),(3,'10000003','Juan','Pérez','juan.perez3@mail.com',1,1),(4,'10000004','Lucía','Ramírez','lucia.ramirez4@mail.com',2,1),(5,'10000005','Pedro','Fernández','pedro.fernandez5@mail.com',1,1),(6,'10000006','Ana','Martínez','ana.martinez6@mail.com',2,1),(7,'10000007','Diego','Rojas','diego.rojas7@mail.com',1,1),(8,'10000008','Laura','Sánchez','laura.sanchez8@mail.com',2,1),(9,'10000009','José','Torres','jose.torres9@mail.com',1,1),(10,'10000010','Carmen','Ruiz','carmen.ruiz10@mail.com',2,1),(11,'10000011','Luis','Castro','luis.castro11@mail.com',1,1),(12,'10000012','Patricia','Delgado','patricia.delgado12@mail.com',2,1),(13,'10000013','Andrés','Flores','andres.flores13@mail.com',1,1),(14,'10000014','Daniela','Vega','daniela.vega14@mail.com',2,1),(15,'10000015','Javier','Morales','javier.morales15@mail.com',1,1),(16,'10000016','Sofía','Navarro','sofia.navarro16@mail.com',2,1),(17,'10000017','Miguel','Reyes','miguel.reyes17@mail.com',1,1),(18,'10000018','Isabel','Cabrera','isabel.cabrera18@mail.com',2,1),(19,'10000019','Oscar','Mendoza','oscar.mendoza19@mail.com',1,1),(20,'10000020','Elena','Silva','elena.silva20@mail.com',2,1),(21,'10000021','Ricardo','Campos','ricardo.campos21@mail.com',1,1),(22,'10000022','Valeria','Paredes','valeria.paredes22@mail.com',2,1),(23,'10000023','Fernando','Acosta','fernando.acosta23@mail.com',1,1),(24,'10000024','Gabriela','Salas','gabriela.salas24@mail.com',2,1),(25,'10000025','Martín','León','martin.leon25@mail.com',1,1),(26,'10000026','Renata','Peña','renata.pena26@mail.com',2,1),(27,'10000027','Víctor','Soto','victor.soto27@mail.com',1,1),(28,'10000028','Mónica','Ríos','monica.rios28@mail.com',2,1),(29,'10000029','Alberto','Mejía','alberto.mejia29@mail.com',1,1),(30,'10000030','Rocío','Vargas','rocio.vargas30@mail.com',2,1),(31,'10000031','Cristian','Ibarra','cristian.ibarra31@mail.com',1,1),(32,'10000032','Noelia','Mora','noelia.mora32@mail.com',2,1),(33,'10000033','Manuel','Carranza','manuel.carranza33@mail.com',1,1),(34,'10000034','Clara','Quispe','clara.quispe34@mail.com',2,1),(35,'10000035','Raúl','Núñez','raul.nunez35@mail.com',1,1),(36,'10000036','Daniela','Guzmán','daniela.guzman36@mail.com',2,1),(37,'10000037','Ángel','Ortega','angel.ortega37@mail.com',1,1),(38,'10000038','Tatiana','Montoya','tatiana.montoya38@mail.com',2,1),(39,'10000039','Fabián','Rentería','fabian.renteria39@mail.com',1,1),(40,'10000040','Camila','Espinoza','camila.espinoza40@mail.com',2,1),(41,'10000041','Sebastián','Valle','sebastian.valle41@mail.com',1,1),(42,'10000042','Luna','Gamarra','luna.gamarra42@mail.com',2,1),(43,'10000043','Iván','Benites','ivan.benites43@mail.com',1,1),(44,'10000044','Carla','Ramos','carla.ramos44@mail.com',2,1),(45,'10000045','Esteban','Solís','esteban.solis45@mail.com',1,1),(46,'10000046','Lorena','Becerra','lorena.becerra46@mail.com',2,1),(47,'10000047','Tomás','Rosales','tomas.rosales47@mail.com',1,1),(48,'10000048','Yesenia','Rivadeneira','yesenia.rivadeneira48@mail.com',2,1),(49,'10000049','Marco','Zambrano','marco.zambrano49@mail.com',1,1),(50,'10000050','Paola','Delgado','paola.delgado50@mail.com',2,1),(51,'00000000','Amet Marcelo','Quispe Espichan','quispeamet2@gmail.com',1,1),(52,'00000000','Amet Marcelo','Quispe Espichan','quispeamet2@gmail.com',1,1),(53,'00000000','Josue ','Sandoval Herrera','josuesandovalherrera26@gmail.com',1,1),(54,'00000000','José Carlos','Hidalgo Romero','U20233784@utp.edu.pe',1,1),(55,'00000000','Michael Olazabal','Yacila','U23236416@UTP.EDU.PE',1,1),(56,'00000000','Patrick Leonel','Heighes Romero','partfirebase12@gmail.com',1,1),(57,'00000001','Amet','Quispe','quispeamet2@gmail.com',3,1),(58,'00000000','Amet Marcelo','Quispe Espichan','quispeamet5@gmail.com',1,1);
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `categoria_id` int NOT NULL,
  `marca` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `stock_minimo` int DEFAULT '0',
  `costo` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'P001',1,'Bosch','Filtro de aceite',25.50,NULL,1,0,7.05),(2,'P002',2,'3M','Ambientador de auto',8.90,NULL,1,0,8.29),(3,'P003',1,'NGK','Bujía estándar',12.00,NULL,1,0,5.00),(4,'P004',2,'Pioneer','Soporte de celular',15.00,NULL,1,0,0.00),(5,'P005',1,'Mobil','Aceite sintético 5W30',39.99,NULL,1,0,0.00),(6,'P006',2,'Armor All','Paño de microfibra',5.50,NULL,1,0,0.00),(7,'P007',1,'ACDelco','Filtro de aire',18.75,NULL,1,0,0.00),(8,'P008',2,'Philips','Bombilla LED H4',22.10,NULL,1,0,3.42),(9,'P009',1,'Denso','Sensor de oxígeno',45.00,NULL,1,0,0.00),(10,'P010',2,'Sony','Cargador USB para auto',10.99,NULL,1,0,0.00),(11,'P011',1,'Bosch','Pastilla de freno delantera',30.50,NULL,1,0,0.00),(12,'P012',2,'Turtle Wax','Cera líquida',12.25,NULL,1,0,0.00),(13,'P013',1,'Champion','Filtro de combustible',20.00,NULL,1,0,0.00),(14,'P014',2,'Kenwood','Parlante 6x9',50.00,NULL,1,0,0.00),(15,'P015',1,'Castrol','Aceite 10W40',28.00,NULL,1,0,9.00),(16,'P016',2,'Meguiar\'s','Limpiavidrios',6.75,NULL,1,0,0.00),(17,'P017',1,'Delphi','Inyector de combustible',85.00,NULL,1,0,0.00),(18,'P018',2,'JBL','Altavoz bluetooth',60.00,NULL,1,0,0.00),(19,'P019',1,'Valeo','Disco de embrague',95.00,NULL,1,0,29.00),(20,'P020',2,'Goodyear','Kit de seguridad',35.00,NULL,1,0,0.00),(21,'P021',1,'Motorcraft','Bobina de encendido',70.00,NULL,1,0,0.00),(22,'P022',2,'Panasonic','Cable auxiliar',4.50,NULL,1,0,0.00),(23,'P023',1,'Autolite','Sensor MAP',40.00,NULL,1,0,0.00),(24,'P024',2,'Belkin','Cargador rápido',14.90,NULL,1,0,0.00),(25,'P025',1,'Bosch','Rotor de freno',55.00,NULL,1,0,0.00),(26,'P026',2,'Kicker','Subwoofer para auto',120.00,NULL,1,0,0.00),(27,'P027',1,'NGK','Cable de bujía',18.00,NULL,1,0,0.00),(28,'P028',2,'Baseus','Soporte magnético',7.90,NULL,1,0,0.00),(29,'P029',1,'ACDelco','Termostato',26.50,NULL,1,0,0.00),(30,'P030',2,'Anker','Cargador de encendedor',11.99,NULL,1,0,15.00),(31,'P031',1,'Denso','Relay automotriz',9.90,NULL,1,0,0.00),(32,'P032',2,'Sony','Adaptador bluetooth',17.50,NULL,1,0,0.00),(33,'P033',1,'Valeo','Sensor ABS',48.00,NULL,1,0,0.00),(34,'P034',2,'Targus','Soporte con ventilador',22.00,NULL,1,0,0.00),(35,'P035',1,'Delphi','Válvula IAC',38.90,NULL,1,0,0.00),(36,'P036',2,'Xiaomi','Luz LED interior',9.50,NULL,1,0,0.00),(37,'P037',1,'Bosch','Bomba de freno',65.00,NULL,1,0,0.00),(38,'P038',2,'Sony','Manos libres',25.00,NULL,1,0,0.00),(39,'P039',1,'Castrol','Grasa multiuso',6.80,NULL,1,0,0.00),(40,'P040',2,'Turtle Wax','Limpiador de llantas',7.20,NULL,1,0,0.00),(41,'P041',1,'Mobil','Líquido de frenos DOT4',9.60,NULL,1,0,0.00),(42,'P042',2,'Armor All','Espuma limpiadora',5.30,NULL,1,0,0.00),(43,'P043',1,'NGK','Sensor de temperatura',21.00,NULL,1,0,0.00),(44,'P044',2,'3M','Esponja de pulido',4.20,NULL,1,0,0.00),(45,'P045',1,'Champion','Cable de batería',8.90,NULL,1,0,0.00),(46,'P046',2,'Meguiar\'s','Cera rápida',10.90,NULL,0,0,0.00),(47,'P047',1,'Valeo','Interruptor de luces',17.40,NULL,1,0,0.00),(48,'P048',2,'Pioneer','Control remoto',15.00,NULL,1,0,0.00),(49,'P049',1,'Autolite','Válvula EGR',49.00,NULL,1,0,0.00),(50,'P050',4,'11111','Organizador de cables',20.00,NULL,0,0,0.00),(54,'P051',2,'Sony','Espejo retrovisor',99.00,NULL,1,0,0.00),(55,'P052',3,'Sony','Funda para timón',80.00,NULL,0,0,0.00),(56,'P053',3,'Turtle Wax','Lubricante de litro',45.00,NULL,0,0,0.00),(57,'P054',1,'Turtle Wax','Llantas',350.00,NULL,0,0,0.00),(59,'P055',2,'Turtle Wax','Funda para timón',150.00,NULL,0,5,135.00);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos_proveedores`
--

DROP TABLE IF EXISTS `productos_proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos_proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `proveedor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `proveedor_id` (`proveedor_id`),
  CONSTRAINT `productos_proveedores_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `productos_proveedores_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `proveedores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos_proveedores`
--

LOCK TABLES `productos_proveedores` WRITE;
/*!40000 ALTER TABLE `productos_proveedores` DISABLE KEYS */;
/*!40000 ALTER TABLE `productos_proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ruc` varchar(15) DEFAULT NULL,
  `razon_social` varchar(50) DEFAULT NULL,
  `ubigeo_id` int DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `contacto` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `ubigeo_id` (`ubigeo_id`),
  CONSTRAINT `proveedores_ibfk_1` FOREIGN KEY (`ubigeo_id`) REFERENCES `ubigeos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedores`
--

LOCK TABLES `proveedores` WRITE;
/*!40000 ALTER TABLE `proveedores` DISABLE KEYS */;
INSERT INTO `proveedores` VALUES (1,'10428255867','Prueba',2,'Prueba','999999999','prueba@gmail.com','Juan',1),(2,'20428255867','Importadora SAC',4,'Calle los Jazminez 12','987456789','importadora@gmail.com','Carmen Reategui',1);
/*!40000 ALTER TABLE `proveedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'asistente',1),(2,'mecánico',1),(3,'administrador',1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `descripcion` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'SRV001','Cambio de aceite','Servicio de cambio de aceite para motor',5.00,70.00,1),(2,'SRV002','Alineamiento','Alineación y balanceo de las llantas',0.00,60.00,1),(3,'SRV003','Revisión general','Inspección completa del vehículo',10.00,120.00,1),(4,'SRV004','Cambio de frenos','Reemplazo de pastillas de freno',0.00,150.00,1),(5,'SRV005','Lavado completo','Lavado exterior e interior del vehículo',0.00,40.00,1);
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubigeos`
--

DROP TABLE IF EXISTS `ubigeos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubigeos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ubigeo` varchar(6) COLLATE utf8mb4_general_ci NOT NULL,
  `departamento` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `provincia` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `distrito` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubigeos`
--

LOCK TABLES `ubigeos` WRITE;
/*!40000 ALTER TABLE `ubigeos` DISABLE KEYS */;
INSERT INTO `ubigeos` VALUES (1,NULL,'150101','Lima','Lima','Lima'),(2,NULL,'150102','Lima','Lima','Ancón'),(3,NULL,'150103','Lima','Lima','Ate'),(4,NULL,'150104','Lima','Lima','Barranco'),(5,NULL,'150105','Lima','Lima','Breña'),(6,NULL,'150106','Lima','Lima','Carabayllo'),(7,NULL,'150107','Lima','Lima','Chaclacayo'),(8,NULL,'150108','Lima','Lima','Chorrillos'),(9,NULL,'150109','Lima','Lima','Cieneguilla'),(10,NULL,'150110','Lima','Lima','Comas'),(11,NULL,'150111','Lima','Lima','El Agustino'),(12,NULL,'150112','Lima','Lima','Independencia'),(13,NULL,'150113','Lima','Lima','Jesús María'),(14,NULL,'150114','Lima','Lima','La Molina'),(15,NULL,'150115','Lima','Lima','La Victoria'),(16,NULL,'150116','Lima','Lima','Lince'),(17,NULL,'150117','Lima','Lima','Los Olivos'),(18,NULL,'150118','Lima','Lima','Lurigancho'),(19,NULL,'150119','Lima','Lima','Lurín'),(20,NULL,'150120','Lima','Lima','Magdalena del Mar'),(21,NULL,'150121','Lima','Lima','Miraflores'),(22,NULL,'150122','Lima','Lima','Pachacamac'),(23,NULL,'150123','Lima','Lima','Pucusana'),(24,NULL,'150124','Lima','Lima','Puente Piedra'),(25,NULL,'150125','Lima','Lima','Rímac'),(26,NULL,'070101','Callao','Callao','Callao'),(27,NULL,'070102','Callao','Callao','Bellavista'),(28,NULL,'070103','Callao','Callao','Carmen de la Legua Reynoso'),(29,NULL,'070104','Callao','Callao','La Perla'),(30,NULL,'070105','Callao','Callao','La Punta'),(31,NULL,'070106','Callao','Callao','Ventanilla'),(32,NULL,'070107','Callao','Callao','Mi Perú');
/*!40000 ALTER TABLE `ubigeos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `persona_id` int NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `rol_id` int DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `persona_id` (`persona_id`),
  KEY `email` (`email`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,52,'quispeamet2@gmail.com','scrypt:32768:8:1$sdXSBWEKUhUMn3dU$dc3d6b7dc6d56fdb789b45845a87cd487799d012f20a63cb7f2857ddcaa67ee79c8bce502619996258167aeba25bf3fcee24ea7fe78ce316b5220435e82230ae',1,NULL,NULL),(2,53,'josuesandovalherrera26@gmail.com','scrypt:32768:8:1$bwvmyefHI0GPMzhG$993aeb0bce6ab6e446b61ecef7ce90d29f475b596d0c3993cf63078b189274a42d6618b374aba43b39097a6a956d302e99b81020f4aad40c7b910c70b33e1384',1,NULL,NULL),(3,54,'U20233784@utp.edu.pe','scrypt:32768:8:1$8sPzyTS2oMzs6ccS$44ea705bc8dab22cbe4f63177b1fc8cdad7207d276f713117ccaaea4af0f368ef57871ec0bac375e3ef79f158a18fdb30ce2dacdf0af4873f7f2c875c44f3cf7',1,NULL,NULL),(4,55,'U23236416@UTP.EDU.PE','scrypt:32768:8:1$r0Hb9kLfZTPbXBK6$a12e792ae83aa817644e44f6f7e6df966ebbea58060c60558428e204d07dcca0651d3e18e7a7064caa9ba90d4bd808d4de67fee6e79bc1ad322d319f993e0dd1',1,NULL,NULL),(5,56,'partfirebase12@gmail.com','scrypt:32768:8:1$24OYUqxE6bCE5yT5$a774f6102b3442342aed2e94fb799dc7e23832ed0ea08f1f023e91ed73714975d972379aa36da30d20f5d9a6cbf49ac29f2ecd3c94cd7e137a3417d72c326f6f',1,NULL,NULL),(6,57,'quispeamet2@gmail.com','pbkdf2:sha256:260000$rUFz42nv3SYWQFnF$dd6d06cdd0d67fa803e9916d6e763d0b5b110cd259b0f0b6bc70a231b0ae3302',1,NULL,NULL),(7,58,'quispeamet5@gmail.com','scrypt:32768:8:1$FOZe0SpcMNgiPWtZ$42e808aaa57682ec01cb80b51a32dc95a4265d728c2ea826e80f1527e394d2983b173b2b01a4f36a35eab5a478591f5b23b13d9ee661c7413bc215175e46e091',1,NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-11 14:40:28
