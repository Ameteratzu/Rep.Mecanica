-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 08-07-2025 a las 06:17:30
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mecanica2`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `automoviles`
--

CREATE TABLE `automoviles` (
  `id` int(11) NOT NULL,
  `cliente_id` int(11) DEFAULT NULL,
  `placa` varchar(10) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `año` int(11) DEFAULT NULL,
  `color` varchar(30) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `automoviles`
--

INSERT INTO `automoviles` (`id`, `cliente_id`, `placa`, `marca`, `modelo`, `año`, `color`, `activo`) VALUES
(1, 1, 'ABC123', 'Toyota', 'Corolla', 2018, 'Rojo', 1),
(2, 2, 'DEF456', 'Hyundai', 'Accent', 2017, 'Negro', 1),
(3, 3, 'GHI789', 'Chevrolet', 'Sail', 2020, 'Blanco', 1),
(4, 4, 'JKL012', 'Nissan', 'Versa', 2019, 'Gris', 1),
(5, 5, 'MNO345', 'Kia', 'Rio', 2016, 'Azul', 1),
(6, 6, 'PQR678', 'Mazda', '3', 2015, 'Plata', 1),
(7, 7, 'STU901', 'Volkswagen', 'Gol', 2021, 'Rojo', 1),
(8, 8, 'VWX234', 'Renault', 'Logan', 2022, 'Negro', 1),
(9, 9, 'YZA567', 'Honda', 'Civic', 2018, 'Blanco', 1),
(10, 10, 'BCD890', 'Suzuki', 'Swift', 2019, 'Verde', 1),
(11, 11, 'EFG123', 'Toyota', 'Yaris', 2020, 'Celeste', 1),
(12, 12, 'HIJ456', 'Chevrolet', 'Aveo', 2017, 'Gris', 1),
(13, 13, 'KLM789', 'Hyundai', 'Elantra', 2016, 'Azul', 1),
(14, 14, 'NOP012', 'Nissan', 'Sentra', 2015, 'Negro', 1),
(15, 15, 'QRS345', 'Kia', 'Cerato', 2018, 'Rojo', 1),
(16, 16, 'TUV678', 'Mazda', '6', 2019, 'Plomo', 1),
(17, 17, 'WXY901', 'Volkswagen', 'Jetta', 2021, 'Blanco', 1),
(18, 18, 'ZAB234', 'Renault', 'Sandero', 2022, 'Verde', 1),
(19, 19, 'CDE567', 'Honda', 'Fit', 2017, 'Amarillo', 1),
(20, 20, 'FGH890', 'Suzuki', 'Baleno', 2018, 'Negro', 1),
(21, 21, 'IJK123', 'Toyota', 'Hilux', 2020, 'Plata', 1),
(22, 22, 'LMN456', 'Chevrolet', 'Tracker', 2021, 'Azul', 1),
(23, 23, 'OPQ789', 'Hyundai', 'Tucson', 2022, 'Rojo', 1),
(24, 24, 'RST012', 'Nissan', 'X-Trail', 2019, 'Negro', 1),
(25, 25, 'UVW345', 'Kia', 'Sportage', 2020, 'Blanco', 1),
(26, 26, 'XYZ678', 'Mazda', 'CX-5', 2021, 'Gris', 1),
(27, 27, 'ABD111', 'Volkswagen', 'Tiguan', 2022, 'Negro', 1),
(28, 28, 'CDE222', 'Renault', 'Duster', 2021, 'Rojo', 1),
(29, 29, 'EFG333', 'Honda', 'HR-V', 2018, 'Blanco', 1),
(30, 30, 'HIJ444', 'Suzuki', 'Vitara', 2019, 'Verde', 1),
(31, 31, 'KLM555', 'Toyota', 'Avanza', 2017, 'Gris', 1),
(32, 32, 'NOP666', 'Chevrolet', 'Spin', 2020, 'Plata', 1),
(33, 33, 'QRS777', 'Hyundai', 'Creta', 2019, 'Azul', 1),
(34, 34, 'TUV888', 'Nissan', 'Kicks', 2022, 'Rojo', 1),
(35, 35, 'WXY999', 'Kia', 'Seltos', 2021, 'Negro', 1),
(36, 36, 'ZAB000', 'Mazda', 'CX-3', 2020, 'Blanco', 1),
(37, 37, 'CDE111', 'Volkswagen', 'Polo', 2016, 'Verde', 1),
(38, 38, 'FGH222', 'Renault', 'Clio', 2015, 'Gris', 1),
(39, 39, 'IJK333', 'Honda', 'City', 2018, 'Plata', 1),
(40, 40, 'LMN444', 'Suzuki', 'Celerio', 2019, 'Negro', 1),
(41, 41, 'OPQ555', 'Toyota', 'Fortuner', 2021, 'Rojo', 1),
(42, 42, 'RST666', 'Chevrolet', 'Captiva', 2020, 'Azul', 1),
(43, 43, 'UVW777', 'Hyundai', 'Santa Fe', 2022, 'Gris', 1),
(44, 44, 'XYZ888', 'Nissan', 'Murano', 2019, 'Blanco', 1),
(45, 45, 'ABD999', 'Kia', 'Sorento', 2021, 'Negro', 1),
(46, 46, 'CDE000', 'Mazda', 'CX-9', 2020, 'Plata', 1),
(47, 47, 'EFG111', 'Volkswagen', 'Passat', 2017, 'Azul', 1),
(48, 48, 'HIJ222', 'Renault', 'Megane', 2018, 'Rojo', 0),
(49, NULL, 'KLM333', 'Honda', 'Odyssey', 2020, 'Gris', 1),
(50, 50, 'NOP444', 'Suzuki', 'Ertiga', 2021, 'Blanco', 1),
(52, 12, 'IAB-122', 'Toyota', 'Yaris', 2020, 'negro', 1),
(53, 1, 'IAB-111', 'Toyota', 'Yaris', 2021, 'Azul', 1),
(54, 4, 'IAB-116', 'Toyota', 'Yaris', 2022, 'Verde', 1),
(55, 2, 'IAB-119', 'Toyota', 'Yaris', 2022, 'Rojo', 1),
(56, 3, 'EEB-119', 'Nissan', 'Sentra', 2022, 'azul', 1),
(57, 3, 'EEB-155', 'Nissan', 'Sentra', 2023, 'Rojo', 1),
(58, 44, 'YHN764', 'Toyota', 'Yaris', 2012, 'Blanco', 1),
(59, 50, 'JCM127', 'Nissan', 'Sentra', 2021, 'Negro', 1),
(60, 51, 'STR176', 'Hyundai', 'Elantra', 2016, 'Gris', 1),
(61, 74, 'YGK358', 'Kia', 'Rio', 2013, 'Azul', 1),
(62, 14, 'ELT360', 'Chevrolet', 'Sail', 2013, 'Rojo', 1),
(63, 33, 'CKS392', 'Mazda', 'CX-5', 2017, 'Plata', 1),
(64, 48, 'GNX127', 'Honda', 'Civic', 2015, 'Verde', 1),
(65, 74, 'CWD961', 'Volkswagen', 'Jetta', 2016, 'Amarillo', 1),
(66, 30, 'JVC970', 'Renault', 'Logan', 2018, 'Marrón', 1),
(67, 71, 'LSF949', 'Suzuki', 'Swift', 2011, 'Celeste', 1),
(68, 60, 'CLW203', 'Toyota', 'Corolla', 2023, 'Blanco', 1),
(69, 25, 'QHQ349', 'Nissan', 'Versa', 2017, 'Negro', 1),
(70, 46, 'FLQ798', 'Hyundai', 'Tucson', 2010, 'Gris', 1),
(71, 65, 'RDQ845', 'Kia', 'Sportage', 2013, 'Azul', 1),
(72, 49, 'EDG874', 'Chevrolet', 'Tracker', 2017, 'Rojo', 1),
(73, 1, 'MIG327', 'Mazda', '3', 2017, 'Plata', 1),
(74, 72, 'PKI391', 'Honda', 'HR-V', 2020, 'Verde', 1),
(75, 43, 'JIN630', 'Volkswagen', 'Gol', 2016, 'Amarillo', 1),
(76, 34, 'PXR763', 'Renault', 'Duster', 2019, 'Marrón', 1),
(77, 78, 'PHQ428', 'Suzuki', 'Vitara', 2023, 'Celeste', 1),
(78, 34, 'GCS382', 'Toyota', 'Hilux', 2016, 'Blanco', 1),
(79, 10, 'IHM642', 'Nissan', 'Kicks', 2017, 'Negro', 1),
(80, 71, 'MZK207', 'Hyundai', 'Creta', 2015, 'Gris', 1),
(81, 48, 'PIW472', 'Kia', 'Seltos', 2016, 'Azul', 1),
(82, 76, 'BQD692', 'Chevrolet', 'Spark', 2023, 'Rojo', 1),
(83, 57, 'LJK117', 'Mazda', '2', 2022, 'Plata', 1),
(84, 11, 'CDI321', 'Honda', 'CR-V', 2013, 'Verde', 1),
(85, 51, 'CTO461', 'Volkswagen', 'T-Cross', 2015, 'Amarillo', 1),
(86, 63, 'LAS653', 'Renault', 'Kwid', 2023, 'Marrón', 1),
(87, 58, 'PZD725', 'Suzuki', 'Ignis', 2011, 'Celeste', 1),
(88, 35, 'RGF382', 'Toyota', 'RAV4', 2023, 'Blanco', 1),
(89, 58, 'NRS693', 'Nissan', 'Frontier', 2011, 'Negro', 1),
(90, 51, 'OBP824', 'Hyundai', 'Kona', 2013, 'Gris', 1),
(91, 74, 'LRC546', 'Kia', 'Picanto', 2012, 'Azul', 1),
(92, 23, 'VLS345', 'Chevrolet', 'Onix', 2012, 'Rojo', 1),
(93, 10, 'ZPZ258', 'Mazda', 'CX-30', 2023, 'Plata', 1),
(94, 6, 'ORP973', 'Honda', 'Ridgeline', 2011, 'Verde', 1),
(95, 44, 'GUC255', 'Volkswagen', 'Virtus', 2018, 'Amarillo', 1),
(96, 29, 'YRO798', 'Renault', 'Stepway', 2013, 'Marrón', 1),
(97, 65, 'BZW392', 'Suzuki', 'S-Cross', 2010, 'Celeste', 1),
(98, 19, 'YAG291', 'Toyota', 'Avanza', 2014, 'Blanco', 1),
(99, 1, 'BEV543', 'Nissan', 'Titan', 2010, 'Negro', 1),
(100, 60, 'JRH460', 'Hyundai', 'Palisade', 2012, 'Gris', 1),
(101, 57, 'TUT350', 'Kia', 'Telluride', 2012, 'Azul', 1),
(102, 11, 'AUU636', 'Chevrolet', 'Colorado', 2019, 'Rojo', 1),
(103, 35, 'BBF843', 'Mazda', 'BT-50', 2017, 'Plata', 1),
(104, 7, 'VZJ838', 'Honda', 'Passport', 2010, 'Verde', 1),
(105, 74, 'BRF168', 'Volkswagen', 'Amarok', 2021, 'Amarillo', 1),
(106, 39, 'AUU656', 'Renault', 'Alaskan', 2021, 'Marrón', 1),
(107, 73, 'ZJW395', 'Suzuki', 'Jimny', 2024, 'Celeste', 1),
(108, 87, 'ZZX680', 'Toyota', 'Sienna', 2017, 'Blanco', 1),
(109, 40, 'WXX913', 'Nissan', 'NV350', 2021, 'Negro', 1),
(110, 11, 'IGG493', 'Hyundai', 'H1', 2017, 'Gris', 1),
(111, 14, 'HZA228', 'Kia', 'Grand Carnival', 2020, 'Azul', 1),
(112, 83, 'STN441', 'Chevrolet', 'Silverado', 2015, 'Rojo', 1),
(113, 54, 'AIN662', 'Mazda', 'MX-5', 2018, 'Plata', 1),
(114, 83, 'BKV976', 'Honda', 'Pilot', 2015, 'Verde', 1),
(115, 84, 'QKA959', 'Volkswagen', 'Touareg', 2020, 'Amarillo', 1),
(116, 50, 'UID828', 'Renault', 'Captur', 2018, 'Marrón', 1),
(117, 49, 'AJW321', 'Suzuki', 'Celerio', 2018, 'Celeste', 1),
(118, 19, 'HVG843', 'Toyota', 'Land Cruiser', 2015, 'Blanco', 1),
(119, 23, 'GNV675', 'Nissan', 'Pathfinder', 2020, 'Negro', 1),
(120, 38, 'DLT508', 'Hyundai', 'Veloster', 2010, 'Gris', 1),
(121, 60, 'KXK345', 'Kia', 'Stinger', 2012, 'Azul', 1),
(122, 82, 'GKG154', 'Chevrolet', 'Camaro', 2018, 'Rojo', 1),
(123, 52, 'HSQ212', 'Mazda', '6', 2020, 'Plata', 1),
(124, 87, 'ZWL602', 'Honda', 'Accord', 2017, 'Verde', 1),
(125, 69, 'LWA498', 'Volkswagen', 'Polo', 2012, 'Amarillo', 1),
(126, 53, 'LLX315', 'Renault', 'Megane', 2016, 'Marrón', 1),
(127, 39, 'YHT796', 'Suzuki', 'Baleno', 2019, 'Celeste', 1),
(128, 86, 'YUA782', 'Toyota', 'Prius', 2021, 'Blanco', 1),
(129, 42, 'DHA317', 'Nissan', 'Leaf', 2012, 'Negro', 1),
(130, 84, 'JZW330', 'Hyundai', 'Ioniq', 2021, 'Gris', 1),
(131, 81, 'LIL189', 'Kia', 'Niro', 2013, 'Azul', 1),
(132, 73, 'MYG509', 'Chevrolet', 'Bolt', 2017, 'Rojo', 1),
(133, 13, 'FPJ196', 'Mazda', 'MX-30', 2015, 'Plata', 1),
(134, 57, 'CLY478', 'Honda', 'Clarity', 2014, 'Verde', 1),
(135, 7, 'OQK259', 'Volkswagen', 'ID.4', 2019, 'Amarillo', 1),
(136, 67, 'WZJ893', 'Renault', 'Zoe', 2014, 'Marrón', 1),
(137, 76, 'KMC204', 'Suzuki', 'Across', 2014, 'Celeste', 1),
(138, 87, 'EUO467', 'Toyota', 'Mirai', 2015, 'Blanco', 1),
(139, 43, 'LRB426', 'Nissan', 'Ariya', 2018, 'Negro', 1),
(140, 73, 'LQY759', 'Hyundai', 'Nexo', 2022, 'Gris', 1),
(141, 12, 'BXH766', 'Kia', 'EV6', 2022, 'Azul', 1),
(142, 7, 'USG131', 'Chevrolet', 'Corvette', 2016, 'Rojo', 1),
(143, 16, 'NAQ108', 'Mazda', 'RX-8', 2012, 'Plata', 1),
(144, 79, 'ZDV657', 'Honda', 'NSX', 2019, 'Verde', 1),
(145, 40, 'HBK822', 'Volkswagen', 'Golf GTI', 2022, 'Amarillo', 1),
(146, 74, 'SYO939', 'Renault', 'Clio RS', 2010, 'Marrón', 1),
(147, 36, 'XHU202', 'Suzuki', 'Swift Sport', 2012, 'Celeste', 1),
(148, 39, 'TIN614', 'Toyota', 'Supra', 2014, 'Blanco', 1),
(149, 68, 'ARI687', 'Nissan', 'GT-R', 2014, 'Negro', 1),
(150, 36, 'GYZ182', 'Hyundai', 'Veloster N', 2017, 'Gris', 1),
(151, 27, 'ZBI504', 'Kia', 'K5 GT', 2013, 'Azul', 1),
(152, 84, 'AGE163', 'Chevrolet', 'Malibu', 2022, 'Rojo', 1),
(153, 9, 'XGN914', 'Mazda', '3', 2023, 'Plata', 1),
(154, 82, 'XSW256', 'Honda', 'CR-Z', 2014, 'Verde', 1),
(155, 74, 'KMD411', 'Volkswagen', 'Scirocco', 2014, 'Amarillo', 1),
(156, 30, 'WJD669', 'Renault', 'Twingo', 2021, 'Marrón', 1),
(157, 75, 'BQC600', 'Suzuki', 'Alto', 2017, 'Celeste', 1),
(158, 65, 'GCS253', 'Toyota', 'C-HR', 2021, 'Blanco', 1),
(159, 33, 'OOG538', 'Nissan', 'Juke', 2020, 'Negro', 1),
(160, 11, 'MAP946', 'Hyundai', 'Venue', 2024, 'Gris', 1),
(161, 74, 'LPT924', 'Kia', 'Soul', 2015, 'Azul', 1),
(162, 84, 'UAU929', 'Chevrolet', 'Equinox', 2013, 'Rojo', 1),
(163, 24, 'SSM332', 'Mazda', 'CX-7', 2022, 'Plata', 1),
(164, 39, 'SER924', 'Honda', 'Pilot', 2018, 'Verde', 1),
(165, 4, 'OOG544', 'Volkswagen', 'Atlas', 2021, 'Amarillo', 1),
(166, 21, 'ZDS193', 'Renault', 'Koleos', 2016, 'Marrón', 1),
(167, 78, 'DAR370', 'Suzuki', 'Grand Vitara', 2017, 'Celeste', 1),
(168, 49, 'HVH945', 'Toyota', 'Sequoia', 2022, 'Blanco', 1),
(169, 28, 'CNG801', 'Nissan', 'Armada', 2011, 'Negro', 1),
(170, 24, 'ZBK860', 'Hyundai', 'Santa Cruz', 2010, 'Gris', 1),
(171, 42, 'JKZ678', 'Kia', 'Carnival', 2014, 'Azul', 1),
(172, 42, 'OIA205', 'Chevrolet', 'Suburban', 2017, 'Rojo', 1),
(173, 15, 'IEY170', 'Mazda', 'CX-90', 2019, 'Plata', 1),
(174, 67, 'AXI936', 'Honda', 'Odyssey', 2020, 'Verde', 1),
(175, 61, 'KWC955', 'Volkswagen', 'Atlas Cross Sport', 2016, 'Amarillo', 1),
(176, 35, 'QYT121', 'Renault', 'Arkana', 2022, 'Marrón', 1),
(177, 11, 'CCG956', 'Suzuki', 'XL7', 2024, 'Celeste', 1),
(178, 12, 'RYQ504', 'Toyota', 'Venza', 2014, 'Blanco', 1),
(179, 17, 'BQB462', 'Nissan', 'Rogue', 2022, 'Negro', 1),
(180, 79, 'AMH112', 'Hyundai', 'Tucson Hybrid', 2012, 'Gris', 1),
(181, 83, 'DVR872', 'Kia', 'Sorento Hybrid', 2014, 'Azul', 1),
(182, 6, 'ILG881', 'Chevrolet', 'Blazer', 2019, 'Rojo', 1),
(183, 47, 'TGX817', 'Mazda', 'CX-50', 2014, 'Plata', 1),
(184, 87, 'DSE787', 'Honda', 'Pilot', 2013, 'Verde', 1),
(185, 3, 'JSN538', 'Volkswagen', 'Taos', 2022, 'Amarillo', 1),
(186, 65, 'FTD493', 'Renault', 'Austral', 2021, 'Marrón', 1),
(187, 54, 'SUT469', 'Suzuki', 'Fronx', 2021, 'Celeste', 1),
(188, 63, 'GAI670', 'Toyota', 'Corolla Cross', 2012, 'Blanco', 1),
(189, 87, 'LFT192', 'Nissan', 'Sentra', 2014, 'Negro', 1),
(190, 4, 'JTR173', 'Hyundai', 'Elantra', 2015, 'Gris', 1),
(191, 64, 'LAV187', 'Kia', 'Rio', 2024, 'Azul', 1),
(192, 48, 'VOH780', 'Chevrolet', 'Sail', 2023, 'Rojo', 1),
(193, 27, 'UBV100', 'Mazda', 'CX-5', 2017, 'Plata', 1),
(194, 56, 'PDW858', 'Honda', 'Civic', 2019, 'Verde', 1),
(195, 70, 'ZOT264', 'Volkswagen', 'Jetta', 2019, 'Amarillo', 1),
(196, 51, 'AHL478', 'Renault', 'Logan', 2020, 'Marrón', 1),
(197, 30, 'NOH818', 'Suzuki', 'Swift', 2011, 'Celeste', 1),
(198, 6, 'BBD610', 'Toyota', 'Yaris', 2015, 'Blanco', 1),
(199, 21, 'AIR483', 'Nissan', 'Versa', 2010, 'Negro', 1),
(200, 1, 'VFM840', 'Hyundai', 'Tucson', 2019, 'Gris', 1),
(201, 73, 'EJH499', 'Kia', 'Sportage', 2014, 'Azul', 1),
(202, 15, 'YGK360', 'Chevrolet', 'Tracker', 2013, 'Rojo', 1),
(203, 20, 'MRX604', 'Mazda', '3', 2011, 'Plata', 1),
(204, 62, 'HHN875', 'Honda', 'HR-V', 2020, 'Verde', 1),
(205, 81, 'NXX771', 'Volkswagen', 'Gol', 2010, 'Amarillo', 1),
(206, 7, 'FUI270', 'Renault', 'Duster', 2010, 'Marrón', 1),
(207, 48, 'RSM454', 'Suzuki', 'Vitara', 2017, 'Celeste', 1),
(208, 17, 'NYG503', 'Toyota', 'Hilux', 2016, 'Blanco', 1),
(209, 84, 'KFT162', 'Nissan', 'Kicks', 2012, 'Negro', 1),
(210, 49, 'IAZ989', 'Hyundai', 'Creta', 2024, 'Gris', 1),
(211, 69, 'CEL812', 'Kia', 'Seltos', 2019, 'Azul', 1),
(212, 60, 'OUH152', 'Chevrolet', 'Spark', 2016, 'Rojo', 1),
(213, 80, 'IWL576', 'Mazda', '2', 2015, 'Plata', 1),
(214, 12, 'PRO797', 'Honda', 'CR-V', 2012, 'Verde', 1),
(215, 53, 'MOK342', 'Volkswagen', 'T-Cross', 2012, 'Amarillo', 1),
(216, 4, 'RGG504', 'Renault', 'Kwid', 2017, 'Marrón', 1),
(217, 25, 'VHX745', 'Suzuki', 'Ignis', 2022, 'Celeste', 1),
(218, 14, 'FNA537', 'Toyota', 'RAV4', 2016, 'Blanco', 1),
(219, 48, 'OCU736', 'Nissan', 'Frontier', 2012, 'Negro', 1),
(220, 58, 'WHW493', 'Hyundai', 'Kona', 2019, 'Gris', 1),
(221, 65, 'WBR378', 'Kia', 'Picanto', 2017, 'Azul', 1),
(222, 39, 'TNI158', 'Chevrolet', 'Onix', 2015, 'Rojo', 1),
(223, 44, 'LVS126', 'Mazda', 'CX-30', 2010, 'Plata', 1),
(224, 19, 'XWQ595', 'Honda', 'Ridgeline', 2022, 'Verde', 1),
(225, 57, 'QHO841', 'Volkswagen', 'Virtus', 2017, 'Amarillo', 1),
(226, 1, 'OSV217', 'Renault', 'Stepway', 2011, 'Marrón', 1),
(227, 21, 'UHC651', 'Suzuki', 'S-Cross', 2021, 'Celeste', 1),
(228, 83, 'MMB787', 'Toyota', 'Avanza', 2020, 'Blanco', 1),
(229, 11, 'OJG137', 'Nissan', 'Titan', 2017, 'Negro', 1),
(230, 38, 'PUA784', 'Hyundai', 'Palisade', 2021, 'Gris', 1),
(231, 47, 'JIL279', 'Kia', 'Telluride', 2020, 'Azul', 1),
(232, 82, 'OZE927', 'Chevrolet', 'Colorado', 2011, 'Rojo', 1),
(233, 70, 'RZU203', 'Mazda', 'BT-50', 2012, 'Plata', 1),
(234, 44, 'ZKB139', 'Honda', 'Passport', 2011, 'Verde', 1),
(235, 24, 'CSG259', 'Volkswagen', 'Amarok', 2011, 'Amarillo', 1),
(236, 82, 'KER831', 'Renault', 'Alaskan', 2011, 'Marrón', 1),
(237, 81, 'KHD927', 'Suzuki', 'Jimny', 2012, 'Celeste', 1),
(238, 87, 'NQP120', 'Toyota', 'Sienna', 2015, 'Blanco', 1),
(239, 67, 'SGC773', 'Nissan', 'NV350', 2016, 'Negro', 1),
(240, 5, 'WFK508', 'Hyundai', 'H1', 2010, 'Gris', 1),
(241, 69, 'VVO481', 'Kia', 'Grand Carnival', 2015, 'Azul', 1),
(242, 64, 'LYN719', 'Chevrolet', 'Silverado', 2023, 'Rojo', 1),
(243, 41, 'QSS523', 'Mazda', 'MX-5', 2012, 'Plata', 1),
(244, 40, 'TMA787', 'Honda', 'Pilot', 2020, 'Verde', 1),
(245, 29, 'LHD800', 'Volkswagen', 'Touareg', 2017, 'Amarillo', 1),
(246, 10, 'BAZ772', 'Renault', 'Captur', 2022, 'Marrón', 1),
(247, 76, 'WSZ750', 'Suzuki', 'Celerio', 2020, 'Celeste', 1),
(248, 31, 'QBM217', 'Toyota', 'Land Cruiser', 2013, 'Blanco', 1),
(249, 79, 'TZQ362', 'Nissan', 'Pathfinder', 2018, 'Negro', 1),
(250, 72, 'MXA529', 'Hyundai', 'Veloster', 2014, 'Gris', 1),
(251, 10, 'PSU856', 'Kia', 'Stinger', 2021, 'Azul', 1),
(252, 41, 'XEE327', 'Chevrolet', 'Camaro', 2021, 'Rojo', 1),
(253, 17, 'PKD619', 'Mazda', '6', 2016, 'Plata', 1),
(254, 46, 'GQM527', 'Honda', 'Accord', 2024, 'Verde', 1),
(255, 26, 'QFF460', 'Volkswagen', 'Polo', 2015, 'Amarillo', 1),
(256, 63, 'LAV189', 'Renault', 'Megane', 2024, 'Marrón', 1),
(257, 54, 'DXZ341', 'Suzuki', 'Baleno', 2015, 'Celeste', 1),
(258, 11, 'LUT330', 'Toyota', 'Prius', 2011, 'Blanco', 1),
(259, 54, 'WLP769', 'Nissan', 'Leaf', 2023, 'Negro', 1),
(260, 19, 'JHH661', 'Hyundai', 'Ioniq', 2013, 'Gris', 1),
(261, 23, 'QIS713', 'Kia', 'Niro', 2013, 'Azul', 1),
(262, 9, 'VVQ667', 'Chevrolet', 'Bolt', 2014, 'Rojo', 1),
(263, 56, 'GJB326', 'Mazda', 'MX-30', 2010, 'Plata', 1),
(264, 43, 'HAD715', 'Honda', 'Clarity', 2010, 'Verde', 1),
(265, 86, 'WLN376', 'Volkswagen', 'ID.4', 2024, 'Amarillo', 1),
(266, 87, 'BFZ310', 'Renault', 'Zoe', 2013, 'Marrón', 1),
(267, 40, 'OMS137', 'Suzuki', 'Across', 2011, 'Celeste', 1),
(268, 42, 'BUU687', 'Toyota', 'Mirai', 2022, 'Blanco', 1),
(269, 27, 'ZYU276', 'Nissan', 'Ariya', 2018, 'Negro', 1),
(270, 21, 'MRY757', 'Hyundai', 'Nexo', 2021, 'Gris', 1),
(271, 71, 'QTV837', 'Kia', 'EV6', 2020, 'Azul', 1),
(272, 81, 'PDZ578', 'Chevrolet', 'Corvette', 2020, 'Rojo', 1),
(273, 68, 'WZG418', 'Mazda', 'RX-8', 2010, 'Plata', 1),
(274, 4, 'EQT772', 'Honda', 'NSX', 2018, 'Verde', 1),
(275, 41, 'SFW794', 'Volkswagen', 'Golf GTI', 2013, 'Amarillo', 1),
(276, 68, 'FUH191', 'Renault', 'Clio RS', 2019, 'Marrón', 1),
(277, 68, 'BWH804', 'Suzuki', 'Swift Sport', 2010, 'Celeste', 1),
(278, 82, 'NSB259', 'Toyota', 'Supra', 2020, 'Blanco', 1),
(279, 81, 'OYE911', 'Nissan', 'GT-R', 2010, 'Negro', 1),
(280, 46, 'MUP617', 'Hyundai', 'Veloster N', 2011, 'Gris', 1),
(281, 61, 'FAM340', 'Kia', 'K5 GT', 2023, 'Azul', 1),
(282, 74, 'LPT874', 'Chevrolet', 'Malibu', 2011, 'Rojo', 1),
(283, 83, 'KER796', 'Mazda', '3', 2023, 'Plata', 1),
(284, 16, 'EIB418', 'Honda', 'CR-Z', 2018, 'Verde', 1),
(285, 82, 'WNZ404', 'Volkswagen', 'Scirocco', 2021, 'Amarillo', 1),
(286, 72, 'VQT840', 'Renault', 'Twingo', 2022, 'Marrón', 1),
(287, 75, 'RUZ506', 'Suzuki', 'Alto', 2015, 'Celeste', 1),
(288, 37, 'AUZ526', 'Toyota', 'C-HR', 2016, 'Blanco', 1),
(289, 72, 'TII693', 'Nissan', 'Juke', 2014, 'Negro', 1),
(290, 59, 'KYL520', 'Hyundai', 'Venue', 2024, 'Gris', 1),
(291, 50, 'WRU826', 'Kia', 'Soul', 2020, 'Azul', 1),
(292, 20, 'XXU312', 'Chevrolet', 'Equinox', 2022, 'Rojo', 1),
(293, 30, 'HKD556', 'Mazda', 'CX-7', 2011, 'Plata', 1),
(294, 5, 'YNT346', 'Honda', 'Pilot', 2011, 'Verde', 1),
(295, 50, 'PJY640', 'Volkswagen', 'Atlas', 2013, 'Amarillo', 1),
(296, 22, 'PFF577', 'Renault', 'Koleos', 2024, 'Marrón', 1),
(297, 29, 'RKX503', 'Suzuki', 'Grand Vitara', 2017, 'Celeste', 1),
(298, 3, 'SNK547', 'Toyota', 'Sequoia', 2013, 'Blanco', 1),
(299, 73, 'JGF344', 'Nissan', 'Armada', 2021, 'Negro', 1),
(300, 82, 'LIK997', 'Hyundai', 'Santa Cruz', 2021, 'Gris', 1),
(301, 81, 'GNT323', 'Kia', 'Carnival', 2024, 'Azul', 1),
(302, 19, 'CUS310', 'Chevrolet', 'Suburban', 2024, 'Rojo', 1),
(303, 24, 'JBG969', 'Mazda', 'CX-90', 2011, 'Plata', 1),
(304, 61, 'DNH848', 'Honda', 'Odyssey', 2014, 'Verde', 1),
(305, 4, 'HJW316', 'Volkswagen', 'Atlas Cross Sport', 2019, 'Amarillo', 1),
(306, 38, 'GYB450', 'Renault', 'Arkana', 2021, 'Marrón', 1),
(307, 68, 'MEI184', 'Suzuki', 'XL7', 2017, 'Celeste', 1),
(308, 30, 'DQU957', 'Toyota', 'Venza', 2016, 'Blanco', 1),
(309, 38, 'USC430', 'Nissan', 'Rogue', 2018, 'Negro', 1),
(310, 61, 'UWY268', 'Hyundai', 'Tucson Hybrid', 2011, 'Gris', 1),
(311, 68, 'RBF974', 'Kia', 'Sorento Hybrid', 2012, 'Azul', 1),
(312, 3, 'OUG847', 'Chevrolet', 'Blazer', 2016, 'Rojo', 1),
(313, 56, 'YTX296', 'Mazda', 'CX-50', 2016, 'Plata', 1),
(314, 45, 'HVH968', 'Honda', 'Pilot', 2024, 'Verde', 1),
(315, 85, 'YSV976', 'Volkswagen', 'Taos', 2015, 'Amarillo', 1),
(316, 3, 'ZVD295', 'Renault', 'Austral', 2020, 'Marrón', 1),
(317, 69, 'XBS331', 'Suzuki', 'Fronx', 2013, 'Celeste', 1),
(318, 1, 'ABC123', 'Toyota', 'Corolla', 2018, 'Rojo', 1),
(319, 2, 'DEF456', 'Hyundai', 'Accent', 2017, 'Negro', 1),
(320, 3, 'GHI789', 'Chevrolet', 'Sail', 2020, 'Blanco', 1),
(321, 4, 'JKL012', 'Nissan', 'Versa', 2019, 'Gris', 1),
(322, 5, 'MNO345', 'Kia', 'Rio', 2016, 'Azul', 1),
(323, 6, 'PQR678', 'Mazda', '3', 2015, 'Plata', 1),
(324, 7, 'STU901', 'Volkswagen', 'Gol', 2021, 'Rojo', 1),
(325, 8, 'VWX234', 'Renault', 'Logan', 2022, 'Negro', 1),
(326, 9, 'YZA567', 'Honda', 'Civic', 2018, 'Blanco', 1),
(327, 10, 'BCD890', 'Suzuki', 'Swift', 2019, 'Verde', 1),
(328, 11, 'EFG123', 'Toyota', 'Yaris', 2020, 'Celeste', 1),
(329, 12, 'HIJ456', 'Chevrolet', 'Aveo', 2017, 'Gris', 1),
(330, 13, 'KLM789', 'Hyundai', 'Elantra', 2016, 'Azul', 1),
(331, 14, 'NOP012', 'Nissan', 'Sentra', 2015, 'Negro', 1),
(332, 15, 'QRS345', 'Kia', 'Cerato', 2018, 'Rojo', 1),
(333, 16, 'TUV678', 'Mazda', '6', 2019, 'Plomo', 1),
(334, 17, 'WXY901', 'Volkswagen', 'Jetta', 2021, 'Blanco', 1),
(335, 18, 'ZAB234', 'Renault', 'Sandero', 2022, 'Verde', 1),
(336, 19, 'CDE567', 'Honda', 'Fit', 2017, 'Amarillo', 1),
(337, 20, 'FGH890', 'Suzuki', 'Baleno', 2018, 'Negro', 1),
(338, 21, 'IJK123', 'Toyota', 'Hilux', 2020, 'Plata', 1),
(339, 22, 'LMN456', 'Chevrolet', 'Tracker', 2021, 'Azul', 1),
(340, 23, 'OPQ789', 'Hyundai', 'Tucson', 2022, 'Rojo', 1),
(341, 24, 'RST012', 'Nissan', 'X-Trail', 2019, 'Negro', 1),
(342, 25, 'UVW345', 'Kia', 'Sportage', 2020, 'Blanco', 1),
(343, 26, 'XYZ678', 'Mazda', 'CX-5', 2021, 'Gris', 1),
(344, 27, 'ABD111', 'Volkswagen', 'Tiguan', 2022, 'Negro', 1),
(345, 28, 'CDE222', 'Renault', 'Duster', 2021, 'Rojo', 1),
(346, 29, 'EFG333', 'Honda', 'HR-V', 2018, 'Blanco', 1),
(347, 30, 'HIJ444', 'Suzuki', 'Vitara', 2019, 'Verde', 1),
(348, 31, 'KLM555', 'Toyota', 'Avanza', 2017, 'Gris', 1),
(349, 32, 'NOP666', 'Chevrolet', 'Spin', 2020, 'Plata', 1),
(350, 33, 'QRS777', 'Hyundai', 'Creta', 2019, 'Azul', 1),
(351, 34, 'TUV888', 'Nissan', 'Kicks', 2022, 'Rojo', 1),
(352, 35, 'WXY999', 'Kia', 'Seltos', 2021, 'Negro', 1),
(353, 36, 'ZAB000', 'Mazda', 'CX-3', 2020, 'Blanco', 1),
(354, 37, 'CDE111', 'Volkswagen', 'Polo', 2016, 'Verde', 1),
(355, 38, 'FGH222', 'Renault', 'Clio', 2015, 'Gris', 1),
(356, 39, 'IJK333', 'Honda', 'City', 2018, 'Plata', 1),
(357, 40, 'LMN444', 'Suzuki', 'Celerio', 2019, 'Negro', 1),
(358, 41, 'OPQ555', 'Toyota', 'Fortuner', 2021, 'Rojo', 1),
(359, 42, 'RST666', 'Chevrolet', 'Captiva', 2020, 'Azul', 1),
(360, 43, 'UVW777', 'Hyundai', 'Santa Fe', 2022, 'Gris', 1),
(361, 44, 'XYZ888', 'Nissan', 'Murano', 2019, 'Blanco', 1),
(362, 45, 'ABD999', 'Kia', 'Sorento', 2021, 'Negro', 1),
(363, 46, 'CDE000', 'Mazda', 'CX-9', 2020, 'Plata', 1),
(364, 47, 'EFG111', 'Volkswagen', 'Passat', 2017, 'Azul', 1),
(365, 48, 'HIJ222', 'Renault', 'Megane', 2018, 'Rojo', 0),
(366, NULL, 'KLM333', 'Honda', 'Odyssey', 2020, 'Gris', 1),
(367, 50, 'NOP444', 'Suzuki', 'Ertiga', 2021, 'Blanco', 1),
(368, 12, 'IAB-122', 'Toyota', 'Yaris', 2020, 'negro', 1),
(369, 1, 'IAB-111', 'Toyota', 'Yaris', 2021, 'Azul', 1),
(370, 4, 'IAB-116', 'Toyota', 'Yaris', 2022, 'Verde', 1),
(371, 2, 'IAB-119', 'Toyota', 'Yaris', 2022, 'Rojo', 1),
(372, 3, 'EEB-119', 'Nissan', 'Sentra', 2022, 'azul', 1),
(373, 3, 'EEB-155', 'Nissan', 'Sentra', 2023, 'Rojo', 1),
(374, 1, 'ABC123', 'Toyota', 'Corolla', 2018, 'Rojo', 1),
(375, 2, 'DEF456', 'Hyundai', 'Accent', 2017, 'Negro', 1),
(376, 3, 'GHI789', 'Chevrolet', 'Sail', 2020, 'Blanco', 1),
(377, 4, 'JKL012', 'Nissan', 'Versa', 2019, 'Gris', 1),
(378, 5, 'MNO345', 'Kia', 'Rio', 2016, 'Azul', 1),
(379, 6, 'PQR678', 'Mazda', '3', 2015, 'Plata', 1),
(380, 7, 'STU901', 'Volkswagen', 'Gol', 2021, 'Rojo', 1),
(381, 8, 'VWX234', 'Renault', 'Logan', 2022, 'Negro', 1),
(382, 9, 'YZA567', 'Honda', 'Civic', 2018, 'Blanco', 1),
(383, 10, 'BCD890', 'Suzuki', 'Swift', 2019, 'Verde', 1),
(384, 11, 'EFG123', 'Toyota', 'Yaris', 2020, 'Celeste', 1),
(385, 12, 'HIJ456', 'Chevrolet', 'Aveo', 2017, 'Gris', 1),
(386, 13, 'KLM789', 'Hyundai', 'Elantra', 2016, 'Azul', 1),
(387, 14, 'NOP012', 'Nissan', 'Sentra', 2015, 'Negro', 1),
(388, 15, 'QRS345', 'Kia', 'Cerato', 2018, 'Rojo', 1),
(389, 16, 'TUV678', 'Mazda', '6', 2019, 'Plomo', 1),
(390, 17, 'WXY901', 'Volkswagen', 'Jetta', 2021, 'Blanco', 1),
(391, 18, 'ZAB234', 'Renault', 'Sandero', 2022, 'Verde', 1),
(392, 19, 'CDE567', 'Honda', 'Fit', 2017, 'Amarillo', 1),
(393, 20, 'FGH890', 'Suzuki', 'Baleno', 2018, 'Negro', 1),
(394, 21, 'IJK123', 'Toyota', 'Hilux', 2020, 'Plata', 1),
(395, 22, 'LMN456', 'Chevrolet', 'Tracker', 2021, 'Azul', 1),
(396, 23, 'OPQ789', 'Hyundai', 'Tucson', 2022, 'Rojo', 1),
(397, 24, 'RST012', 'Nissan', 'X-Trail', 2019, 'Negro', 1),
(398, 25, 'UVW345', 'Kia', 'Sportage', 2020, 'Blanco', 1),
(399, 26, 'XYZ678', 'Mazda', 'CX-5', 2021, 'Gris', 1),
(400, 27, 'ABD111', 'Volkswagen', 'Tiguan', 2022, 'Negro', 1),
(401, 28, 'CDE222', 'Renault', 'Duster', 2021, 'Rojo', 1),
(402, 29, 'EFG333', 'Honda', 'HR-V', 2018, 'Blanco', 1),
(403, 30, 'HIJ444', 'Suzuki', 'Vitara', 2019, 'Verde', 1),
(404, 31, 'KLM555', 'Toyota', 'Avanza', 2017, 'Gris', 1),
(405, 32, 'NOP666', 'Chevrolet', 'Spin', 2020, 'Plata', 1),
(406, 33, 'QRS777', 'Hyundai', 'Creta', 2019, 'Azul', 1),
(407, 34, 'TUV888', 'Nissan', 'Kicks', 2022, 'Rojo', 1),
(408, 35, 'WXY999', 'Kia', 'Seltos', 2021, 'Negro', 1),
(409, 36, 'ZAB000', 'Mazda', 'CX-3', 2020, 'Blanco', 1),
(410, 37, 'CDE111', 'Volkswagen', 'Polo', 2016, 'Verde', 1),
(411, 38, 'FGH222', 'Renault', 'Clio', 2015, 'Gris', 1),
(412, 39, 'IJK333', 'Honda', 'City', 2018, 'Plata', 1),
(413, 40, 'LMN444', 'Suzuki', 'Celerio', 2019, 'Negro', 1),
(414, 41, 'OPQ555', 'Toyota', 'Fortuner', 2021, 'Rojo', 1),
(415, 42, 'RST666', 'Chevrolet', 'Captiva', 2020, 'Azul', 1),
(416, 43, 'UVW777', 'Hyundai', 'Santa Fe', 2022, 'Gris', 1),
(417, 44, 'XYZ888', 'Nissan', 'Murano', 2019, 'Blanco', 1),
(418, 45, 'ABD999', 'Kia', 'Sorento', 2021, 'Negro', 1),
(419, 46, 'CDE000', 'Mazda', 'CX-9', 2020, 'Plata', 1),
(420, 47, 'EFG111', 'Volkswagen', 'Passat', 2017, 'Azul', 1),
(421, 48, 'HIJ222', 'Renault', 'Megane', 2018, 'Rojo', 0),
(422, NULL, 'KLM333', 'Honda', 'Odyssey', 2020, 'Gris', 1),
(423, 50, 'NOP444', 'Suzuki', 'Ertiga', 2021, 'Blanco', 1),
(424, 12, 'IAB-122', 'Toyota', 'Yaris', 2020, 'negro', 1),
(425, 1, 'IAB-111', 'Toyota', 'Yaris', 2021, 'Azul', 1),
(426, 4, 'IAB-116', 'Toyota', 'Yaris', 2022, 'Verde', 1),
(427, 2, 'IAB-119', 'Toyota', 'Yaris', 2022, 'Rojo', 1),
(428, 3, 'EEB-119', 'Nissan', 'Sentra', 2022, 'azul', 1),
(429, 3, 'EEB-155', 'Nissan', 'Sentra', 2023, 'Rojo', 1),
(430, 1, 'ABC123', 'Toyota', 'Corolla', 2018, 'Rojo', 1),
(431, 2, 'DEF456', 'Hyundai', 'Accent', 2017, 'Negro', 1),
(432, 3, 'GHI789', 'Chevrolet', 'Sail', 2020, 'Blanco', 1),
(433, 4, 'JKL012', 'Nissan', 'Versa', 2019, 'Gris', 1),
(434, 5, 'MNO345', 'Kia', 'Rio', 2016, 'Azul', 1),
(435, 6, 'PQR678', 'Mazda', '3', 2015, 'Plata', 1),
(436, 7, 'STU901', 'Volkswagen', 'Gol', 2021, 'Rojo', 1),
(437, 8, 'VWX234', 'Renault', 'Logan', 2022, 'Negro', 1),
(438, 9, 'YZA567', 'Honda', 'Civic', 2018, 'Blanco', 1),
(439, 10, 'BCD890', 'Suzuki', 'Swift', 2019, 'Verde', 1),
(440, 11, 'EFG123', 'Toyota', 'Yaris', 2020, 'Celeste', 1),
(441, 12, 'HIJ456', 'Chevrolet', 'Aveo', 2017, 'Gris', 1),
(442, 13, 'KLM789', 'Hyundai', 'Elantra', 2016, 'Azul', 1),
(443, 14, 'NOP012', 'Nissan', 'Sentra', 2015, 'Negro', 1),
(444, 15, 'QRS345', 'Kia', 'Cerato', 2018, 'Rojo', 1),
(445, 16, 'TUV678', 'Mazda', '6', 2019, 'Plomo', 1),
(446, 17, 'WXY901', 'Volkswagen', 'Jetta', 2021, 'Blanco', 1),
(447, 18, 'ZAB234', 'Renault', 'Sandero', 2022, 'Verde', 1),
(448, 19, 'CDE567', 'Honda', 'Fit', 2017, 'Amarillo', 1),
(449, 20, 'FGH890', 'Suzuki', 'Baleno', 2018, 'Negro', 1),
(450, 21, 'IJK123', 'Toyota', 'Hilux', 2020, 'Plata', 1),
(451, 22, 'LMN456', 'Chevrolet', 'Tracker', 2021, 'Azul', 1),
(452, 23, 'OPQ789', 'Hyundai', 'Tucson', 2022, 'Rojo', 1),
(453, 24, 'RST012', 'Nissan', 'X-Trail', 2019, 'Negro', 1),
(454, 25, 'UVW345', 'Kia', 'Sportage', 2020, 'Blanco', 1),
(455, 26, 'XYZ678', 'Mazda', 'CX-5', 2021, 'Gris', 1),
(456, 27, 'ABD111', 'Volkswagen', 'Tiguan', 2022, 'Negro', 1),
(457, 28, 'CDE222', 'Renault', 'Duster', 2021, 'Rojo', 1),
(458, 29, 'EFG333', 'Honda', 'HR-V', 2018, 'Blanco', 1),
(459, 30, 'HIJ444', 'Suzuki', 'Vitara', 2019, 'Verde', 1),
(460, 31, 'KLM555', 'Toyota', 'Avanza', 2017, 'Gris', 1),
(461, 32, 'NOP666', 'Chevrolet', 'Spin', 2020, 'Plata', 1),
(462, 33, 'QRS777', 'Hyundai', 'Creta', 2019, 'Azul', 1),
(463, 34, 'TUV888', 'Nissan', 'Kicks', 2022, 'Rojo', 1),
(464, 35, 'WXY999', 'Kia', 'Seltos', 2021, 'Negro', 1),
(465, 36, 'ZAB000', 'Mazda', 'CX-3', 2020, 'Blanco', 1),
(466, 37, 'CDE111', 'Volkswagen', 'Polo', 2016, 'Verde', 1),
(467, 38, 'FGH222', 'Renault', 'Clio', 2015, 'Gris', 1),
(468, 39, 'IJK333', 'Honda', 'City', 2018, 'Plata', 1),
(469, 40, 'LMN444', 'Suzuki', 'Celerio', 2019, 'Negro', 1),
(470, 41, 'OPQ555', 'Toyota', 'Fortuner', 2021, 'Rojo', 1),
(471, 42, 'RST666', 'Chevrolet', 'Captiva', 2020, 'Azul', 1),
(472, 43, 'UVW777', 'Hyundai', 'Santa Fe', 2022, 'Gris', 1),
(473, 44, 'XYZ888', 'Nissan', 'Murano', 2019, 'Blanco', 1),
(474, 45, 'ABD999', 'Kia', 'Sorento', 2021, 'Negro', 1),
(475, 46, 'CDE000', 'Mazda', 'CX-9', 2020, 'Plata', 1),
(476, 47, 'EFG111', 'Volkswagen', 'Passat', 2017, 'Azul', 1),
(477, 48, 'HIJ222', 'Renault', 'Megane', 2018, 'Rojo', 0),
(478, NULL, 'KLM333', 'Honda', 'Odyssey', 2020, 'Gris', 1),
(479, 50, 'NOP444', 'Suzuki', 'Ertiga', 2021, 'Blanco', 1),
(480, 12, 'IAB-122', 'Toyota', 'Yaris', 2020, 'negro', 1),
(481, 1, 'IAB-111', 'Toyota', 'Yaris', 2021, 'Azul', 1),
(482, 4, 'IAB-116', 'Toyota', 'Yaris', 2022, 'Verde', 1),
(483, 2, 'IAB-119', 'Toyota', 'Yaris', 2022, 'Rojo', 1),
(484, 3, 'EEB-119', 'Nissan', 'Sentra', 2022, 'azul', 1),
(485, 3, 'EEB-155', 'Nissan', 'Sentra', 2023, 'Rojo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `categoria`, `activo`) VALUES
(1, 'repuestos', 1),
(2, 'accesorios', 1),
(3, 'lubricantes', 1),
(4, 'herramientas', 1),
(5, 'neumáticos', 1),
(6, 'repuestos', 1),
(7, 'accesorios', 1),
(8, 'lubricantes', 1),
(9, 'herramientas', 1),
(10, 'neumáticos', 1),
(11, 'repuestos', 1),
(12, 'accesorios', 1),
(13, 'lubricantes', 1),
(14, 'herramientas', 1),
(15, 'neumáticos', 1),
(16, 'repuestos', 1),
(17, 'accesorios', 1),
(18, 'lubricantes', 1),
(19, 'herramientas', 1),
(20, 'neumáticos', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `tipoDocumento` varchar(20) NOT NULL DEFAULT 'DNI',
  `correo` varchar(120) DEFAULT NULL,
  `ubigeo_id` int(11) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `celular` varchar(15) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `tipo_documento` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `documento`, `nombres`, `apellidos`, `tipoDocumento`, `correo`, `ubigeo_id`, `direccion`, `celular`, `activo`, `tipo_documento`) VALUES
(1, '70000001', 'Luis', 'Vargas', 'DNI', NULL, 1, 'Av. Arequipa 123', '987654321', 1, NULL),
(2, '70000002', 'Ana', 'Pérez', 'DNI', NULL, 2, 'Jr. Libertad 456', '987654322', 1, NULL),
(3, '70000003', 'Carlos', 'Ramírez', 'DNI', NULL, 3, 'Av. Metropolitana 789', '987654323', 1, NULL),
(4, '70000004', 'María', 'Gonzales', 'DNI', NULL, 4, 'Calle Italia 234', '987654324', 1, NULL),
(5, '70000005', 'José', 'López', 'DNI', NULL, 5, 'Av. Brasil 567', '987654325', 1, NULL),
(6, '70000006', 'Lucía', 'Torres', 'DNI', NULL, 6, 'Av. Túpac Amaru 890', '987654326', 1, NULL),
(7, '70000007', 'Javier', 'Morales', 'DNI', NULL, 7, 'Jr. Los Álamos 101', '987654327', 1, NULL),
(8, '70000008', 'Diana', 'Fernández', 'DNI', NULL, 8, 'Av. Huaylas 202', '987654328', 1, NULL),
(9, '70000009', 'Renato', 'Sánchez', 'DNI', NULL, 9, 'Calle Sol Naciente 303', '987654329', 1, NULL),
(10, '70000010', 'Sofía', 'Martínez', 'DNI', NULL, 10, 'Av. Universitaria 404', '987654330', 1, NULL),
(11, '70000011', 'Pedro', 'Salas', 'DNI', NULL, 11, 'Jr. César Vallejo 505', '987654331', 1, NULL),
(12, '70000012', 'Carmen', 'Cruz', 'DNI', NULL, 12, 'Av. Tomás Valle 606', '987654332', 1, NULL),
(13, '70000013', 'Héctor', 'Navarro', 'DNI', NULL, 13, 'Calle Tarata 707', '987654333', 1, NULL),
(14, '70000014', 'Vanessa', 'Reyes', 'DNI', NULL, 14, 'Av. Flora Tristán 808', '987654334', 1, NULL),
(15, '70000015', 'Jorge', 'Ibáñez', 'DNI', NULL, 15, 'Jr. Gamarra 909', '987654335', 1, NULL),
(16, '70000016', 'Natalia', 'Pacheco', 'DNI', NULL, 16, 'Av. Canevaro 111', '987654336', 1, NULL),
(17, '70000017', 'Diego', 'Ortega', 'DNI', NULL, 17, 'Calle Los Jazmines 222', '987654337', 1, NULL),
(18, '70000018', 'Andrea', 'Luna', 'DNI', NULL, 18, 'Av. Wiesse 333', '987654338', 1, NULL),
(19, '70000019', 'Martín', 'Camacho', 'DNI', NULL, 19, 'Jr. Los Olivos 444', '987654339', 1, NULL),
(20, '70000020', 'Rosa', 'Aguilar', 'DNI', NULL, 20, 'Av. Brasil 555', '987654340', 1, NULL),
(21, '70000021', 'Oscar', 'Delgado', 'DNI', NULL, 21, 'Av. Larco 666', '987654341', 1, NULL),
(22, '70000022', 'Julia', 'Montoya', 'DNI', NULL, 22, 'Calle Primavera 777', '987654342', 1, NULL),
(23, '70000023', 'Ángel', 'Soto', 'DNI', NULL, 23, 'Av. Malecon 888', '987654343', 1, NULL),
(24, '70000024', 'Claudia', 'Mejía', 'DNI', NULL, 24, 'Jr. Zarumilla 999', '987654344', 1, NULL),
(25, '70000025', 'Fernando', 'Gamarra', 'DNI', NULL, 25, 'Av. Alcázar 1110', '987654345', 1, NULL),
(26, '70000026', 'Tatiana', 'Rosales', 'DNI', NULL, 26, 'Calle 2 de Mayo 1212', '987654346', 1, NULL),
(27, '70000027', 'Iván', 'Villanueva', 'DNI', NULL, 27, 'Jr. América 1313', '987654347', 1, NULL),
(28, '70000028', 'Camila', 'Rivas', 'DNI', NULL, 28, 'Av. Colonial 1414', '987654348', 1, NULL),
(29, '70000029', 'Cristina', 'Becerra', 'DNI', NULL, 29, 'Calle San Martín 1515', '987654349', 1, NULL),
(30, '70000030', 'Esteban', 'Ruiz', 'DNI', NULL, 30, 'Jr. Salaverry 1616', '987654350', 1, NULL),
(31, '70000031', 'Paola', 'Zambrano', 'DNI', NULL, 31, 'Av. Néstor Gambetta 1717', '987654351', 1, NULL),
(32, '70000032', 'Tomás', 'Cabrera', 'DNI', NULL, 32, 'Av. Mi Perú 1818', '987654352', 1, NULL),
(33, '70000033', 'Gabriela', 'Mendoza', 'DNI', NULL, 5, 'Av. Venezuela 1919', '987654353', 1, NULL),
(34, '70000034', 'Andrés', 'Silva', 'DNI', NULL, 8, 'Jr. Sucre 2020', '987654354', 1, NULL),
(35, '70000035', 'Melissa', 'Quispe', 'DNI', NULL, 12, 'Calle Real 2121', '987654355', 1, NULL),
(36, '70000036', 'Alan', 'Castañeda', 'DNI', NULL, 15, 'Av. Javier Prado 2222', '987654356', 1, NULL),
(37, '70000037', 'Fiorella', 'León', 'DNI', NULL, 3, 'Calle Primavera 2323', '987654357', 1, NULL),
(38, '70000038', 'Rodrigo', 'Vargas', 'DNI', NULL, 9, 'Av. Las Torres 2424', '987654358', 1, NULL),
(39, '70000039', 'Patricia', 'Barreto', 'DNI', NULL, 14, 'Jr. Arica 2525', '987654359', 1, NULL),
(40, '70000040', 'Kevin', 'Alfaro', 'DNI', NULL, 19, 'Calle 28 de Julio 2626', '987654360', 1, NULL),
(41, '70000041', 'Mónica', 'Espinoza', 'DNI', NULL, 21, 'Av. Grau 2727', '987654361', 1, NULL),
(42, '70000042', 'Enrique', 'Solís', 'DNI', NULL, 11, 'Jr. Lima 2828', '987654362', 1, NULL),
(43, '70000043', 'Lorena', 'Velásquez', 'DNI', NULL, 6, 'Av. Trapiche 2929', '987654363', 1, NULL),
(44, '70000044', 'Álvaro', 'Cornejo', 'DNI', NULL, 13, 'Jr. Puno 3030', '987654364', 1, NULL),
(45, '70000045', 'Daniela', 'Del Carpio', 'DNI', NULL, 7, 'Av. Las Palmeras 3131', '987654365', 1, NULL),
(46, '70000046', 'Bruno', 'Galván', 'DNI', NULL, 18, 'Jr. José Olaya 3232', '987654366', 1, NULL),
(47, '70000047', 'Luisa', 'Gómez', 'DNI', NULL, 20, 'Av. Ejército 3333', '987654367', 1, NULL),
(48, '70000048', 'César', 'Ríos', 'DNI', NULL, 22, 'Calle Comercio 3434', '987654368', 1, NULL),
(50, '70000050', 'Sebastián', 'Cáceres', 'DNI', NULL, 27, 'Jr. Talara 3636', '9876543444', 1, NULL),
(55, '74372087', 'Amet Marcelo', 'Quispe Espichan', 'DNI', 'quispeamet2@gmail.com', 27, 'C. las azucenas', '931262732', 1, NULL),
(84, '47897897', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 9, 'Calle los Jazminez156', '9876543444', 1, NULL),
(85, '41414141', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 11, 'Calle los Jazminez156', '9876543444', 1, NULL),
(87, '45612345', 'Carlos', 'Martinez Martinez', 'DNI', 'cmartinez@gmail.com', 2, 'Calle los Jazminez 12', '965789789', 1, NULL),
(88, '70000001', 'Luis', 'Vargas', 'DNI', NULL, 1, 'Av. Arequipa 123', '987654321', 1, NULL),
(89, '70000002', 'Ana', 'Pérez', 'DNI', NULL, 2, 'Jr. Libertad 456', '987654322', 1, NULL),
(90, '70000003', 'Carlos', 'Ramírez', 'DNI', NULL, 3, 'Av. Metropolitana 789', '987654323', 1, NULL),
(91, '70000004', 'María', 'Gonzales', 'DNI', NULL, 4, 'Calle Italia 234', '987654324', 1, NULL),
(92, '70000005', 'José', 'López', 'DNI', NULL, 5, 'Av. Brasil 567', '987654325', 1, NULL),
(93, '70000006', 'Lucía', 'Torres', 'DNI', NULL, 6, 'Av. Túpac Amaru 890', '987654326', 1, NULL),
(94, '70000007', 'Javier', 'Morales', 'DNI', NULL, 7, 'Jr. Los Álamos 101', '987654327', 1, NULL),
(95, '70000008', 'Diana', 'Fernández', 'DNI', NULL, 8, 'Av. Huaylas 202', '987654328', 1, NULL),
(96, '70000009', 'Renato', 'Sánchez', 'DNI', NULL, 9, 'Calle Sol Naciente 303', '987654329', 1, NULL),
(97, '70000010', 'Sofía', 'Martínez', 'DNI', NULL, 10, 'Av. Universitaria 404', '987654330', 1, NULL),
(98, '70000011', 'Pedro', 'Salas', 'DNI', NULL, 11, 'Jr. César Vallejo 505', '987654331', 1, NULL),
(99, '70000012', 'Carmen', 'Cruz', 'DNI', NULL, 12, 'Av. Tomás Valle 606', '987654332', 1, NULL),
(100, '70000013', 'Héctor', 'Navarro', 'DNI', NULL, 13, 'Calle Tarata 707', '987654333', 1, NULL),
(101, '70000014', 'Vanessa', 'Reyes', 'DNI', NULL, 14, 'Av. Flora Tristán 808', '987654334', 1, NULL),
(102, '70000015', 'Jorge', 'Ibáñez', 'DNI', NULL, 15, 'Jr. Gamarra 909', '987654335', 1, NULL),
(103, '70000016', 'Natalia', 'Pacheco', 'DNI', NULL, 16, 'Av. Canevaro 111', '987654336', 1, NULL),
(104, '70000017', 'Diego', 'Ortega', 'DNI', NULL, 17, 'Calle Los Jazmines 222', '987654337', 1, NULL),
(105, '70000018', 'Andrea', 'Luna', 'DNI', NULL, 18, 'Av. Wiesse 333', '987654338', 1, NULL),
(106, '70000019', 'Martín', 'Camacho', 'DNI', NULL, 19, 'Jr. Los Olivos 444', '987654339', 1, NULL),
(107, '70000020', 'Rosa', 'Aguilar', 'DNI', NULL, 20, 'Av. Brasil 555', '987654340', 1, NULL),
(108, '70000021', 'Oscar', 'Delgado', 'DNI', NULL, 21, 'Av. Larco 666', '987654341', 1, NULL),
(109, '70000022', 'Julia', 'Montoya', 'DNI', NULL, 22, 'Calle Primavera 777', '987654342', 1, NULL),
(110, '70000023', 'Ángel', 'Soto', 'DNI', NULL, 23, 'Av. Malecon 888', '987654343', 1, NULL),
(111, '70000024', 'Claudia', 'Mejía', 'DNI', NULL, 24, 'Jr. Zarumilla 999', '987654344', 1, NULL),
(112, '70000025', 'Fernando', 'Gamarra', 'DNI', NULL, 25, 'Av. Alcázar 1110', '987654345', 1, NULL),
(113, '70000026', 'Tatiana', 'Rosales', 'DNI', NULL, 26, 'Calle 2 de Mayo 1212', '987654346', 1, NULL),
(114, '70000027', 'Iván', 'Villanueva', 'DNI', NULL, 27, 'Jr. América 1313', '987654347', 1, NULL),
(115, '70000028', 'Camila', 'Rivas', 'DNI', NULL, 28, 'Av. Colonial 1414', '987654348', 1, NULL),
(116, '70000029', 'Cristina', 'Becerra', 'DNI', NULL, 29, 'Calle San Martín 1515', '987654349', 1, NULL),
(117, '70000030', 'Esteban', 'Ruiz', 'DNI', NULL, 30, 'Jr. Salaverry 1616', '987654350', 1, NULL),
(118, '70000031', 'Paola', 'Zambrano', 'DNI', NULL, 31, 'Av. Néstor Gambetta 1717', '987654351', 1, NULL),
(119, '70000032', 'Tomás', 'Cabrera', 'DNI', NULL, 32, 'Av. Mi Perú 1818', '987654352', 1, NULL),
(120, '70000033', 'Gabriela', 'Mendoza', 'DNI', NULL, 5, 'Av. Venezuela 1919', '987654353', 1, NULL),
(121, '70000034', 'Andrés', 'Silva', 'DNI', NULL, 8, 'Jr. Sucre 2020', '987654354', 1, NULL),
(122, '70000035', 'Melissa', 'Quispe', 'DNI', NULL, 12, 'Calle Real 2121', '987654355', 1, NULL),
(123, '70000036', 'Alan', 'Castañeda', 'DNI', NULL, 15, 'Av. Javier Prado 2222', '987654356', 1, NULL),
(124, '70000037', 'Fiorella', 'León', 'DNI', NULL, 3, 'Calle Primavera 2323', '987654357', 1, NULL),
(125, '70000038', 'Rodrigo', 'Vargas', 'DNI', NULL, 9, 'Av. Las Torres 2424', '987654358', 1, NULL),
(126, '70000039', 'Patricia', 'Barreto', 'DNI', NULL, 14, 'Jr. Arica 2525', '987654359', 1, NULL),
(127, '70000040', 'Kevin', 'Alfaro', 'DNI', NULL, 19, 'Calle 28 de Julio 2626', '987654360', 1, NULL),
(128, '70000041', 'Mónica', 'Espinoza', 'DNI', NULL, 21, 'Av. Grau 2727', '987654361', 1, NULL),
(129, '70000042', 'Enrique', 'Solís', 'DNI', NULL, 11, 'Jr. Lima 2828', '987654362', 1, NULL),
(130, '70000043', 'Lorena', 'Velásquez', 'DNI', NULL, 6, 'Av. Trapiche 2929', '987654363', 1, NULL),
(131, '70000044', 'Álvaro', 'Cornejo', 'DNI', NULL, 13, 'Jr. Puno 3030', '987654364', 1, NULL),
(132, '70000045', 'Daniela', 'Del Carpio', 'DNI', NULL, 7, 'Av. Las Palmeras 3131', '987654365', 1, NULL),
(133, '70000046', 'Bruno', 'Galván', 'DNI', NULL, 18, 'Jr. José Olaya 3232', '987654366', 1, NULL),
(134, '70000047', 'Luisa', 'Gómez', 'DNI', NULL, 20, 'Av. Ejército 3333', '987654367', 1, NULL),
(135, '70000048', 'César', 'Ríos', 'DNI', NULL, 22, 'Calle Comercio 3434', '987654368', 1, NULL),
(136, '70000050', 'Sebastián', 'Cáceres', 'DNI', NULL, 27, 'Jr. Talara 3636', '9876543444', 1, NULL),
(137, '74372087', 'Amet Marcelo', 'Quispe Espichan', 'DNI', 'quispeamet2@gmail.com', 27, 'C. las azucenas', '931262732', 1, NULL),
(138, '47897897', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 9, 'Calle los Jazminez156', '9876543444', 1, NULL),
(139, '41414141', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 11, 'Calle los Jazminez156', '9876543444', 1, NULL),
(140, '45612345', 'Carlos', 'Martinez Martinez', 'DNI', 'cmartinez@gmail.com', 2, 'Calle los Jazminez 12', '965789789', 1, NULL),
(141, '70000001', 'Luis', 'Vargas', 'DNI', NULL, 1, 'Av. Arequipa 123', '987654321', 1, NULL),
(142, '70000002', 'Ana', 'Pérez', 'DNI', NULL, 2, 'Jr. Libertad 456', '987654322', 1, NULL),
(143, '70000003', 'Carlos', 'Ramírez', 'DNI', NULL, 3, 'Av. Metropolitana 789', '987654323', 1, NULL),
(144, '70000004', 'María', 'Gonzales', 'DNI', NULL, 4, 'Calle Italia 234', '987654324', 1, NULL),
(145, '70000005', 'José', 'López', 'DNI', NULL, 5, 'Av. Brasil 567', '987654325', 1, NULL),
(146, '70000006', 'Lucía', 'Torres', 'DNI', NULL, 6, 'Av. Túpac Amaru 890', '987654326', 1, NULL),
(147, '70000007', 'Javier', 'Morales', 'DNI', NULL, 7, 'Jr. Los Álamos 101', '987654327', 1, NULL),
(148, '70000008', 'Diana', 'Fernández', 'DNI', NULL, 8, 'Av. Huaylas 202', '987654328', 1, NULL),
(149, '70000009', 'Renato', 'Sánchez', 'DNI', NULL, 9, 'Calle Sol Naciente 303', '987654329', 1, NULL),
(150, '70000010', 'Sofía', 'Martínez', 'DNI', NULL, 10, 'Av. Universitaria 404', '987654330', 1, NULL),
(151, '70000011', 'Pedro', 'Salas', 'DNI', NULL, 11, 'Jr. César Vallejo 505', '987654331', 1, NULL),
(152, '70000012', 'Carmen', 'Cruz', 'DNI', NULL, 12, 'Av. Tomás Valle 606', '987654332', 1, NULL),
(153, '70000013', 'Héctor', 'Navarro', 'DNI', NULL, 13, 'Calle Tarata 707', '987654333', 1, NULL),
(154, '70000014', 'Vanessa', 'Reyes', 'DNI', NULL, 14, 'Av. Flora Tristán 808', '987654334', 1, NULL),
(155, '70000015', 'Jorge', 'Ibáñez', 'DNI', NULL, 15, 'Jr. Gamarra 909', '987654335', 1, NULL),
(156, '70000016', 'Natalia', 'Pacheco', 'DNI', NULL, 16, 'Av. Canevaro 111', '987654336', 1, NULL),
(157, '70000017', 'Diego', 'Ortega', 'DNI', NULL, 17, 'Calle Los Jazmines 222', '987654337', 1, NULL),
(158, '70000018', 'Andrea', 'Luna', 'DNI', NULL, 18, 'Av. Wiesse 333', '987654338', 1, NULL),
(159, '70000019', 'Martín', 'Camacho', 'DNI', NULL, 19, 'Jr. Los Olivos 444', '987654339', 1, NULL),
(160, '70000020', 'Rosa', 'Aguilar', 'DNI', NULL, 20, 'Av. Brasil 555', '987654340', 1, NULL),
(161, '70000021', 'Oscar', 'Delgado', 'DNI', NULL, 21, 'Av. Larco 666', '987654341', 1, NULL),
(162, '70000022', 'Julia', 'Montoya', 'DNI', NULL, 22, 'Calle Primavera 777', '987654342', 1, NULL),
(163, '70000023', 'Ángel', 'Soto', 'DNI', NULL, 23, 'Av. Malecon 888', '987654343', 1, NULL),
(164, '70000024', 'Claudia', 'Mejía', 'DNI', NULL, 24, 'Jr. Zarumilla 999', '987654344', 1, NULL),
(165, '70000025', 'Fernando', 'Gamarra', 'DNI', NULL, 25, 'Av. Alcázar 1110', '987654345', 1, NULL),
(166, '70000026', 'Tatiana', 'Rosales', 'DNI', NULL, 26, 'Calle 2 de Mayo 1212', '987654346', 1, NULL),
(167, '70000027', 'Iván', 'Villanueva', 'DNI', NULL, 27, 'Jr. América 1313', '987654347', 1, NULL),
(168, '70000028', 'Camila', 'Rivas', 'DNI', NULL, 28, 'Av. Colonial 1414', '987654348', 1, NULL),
(169, '70000029', 'Cristina', 'Becerra', 'DNI', NULL, 29, 'Calle San Martín 1515', '987654349', 1, NULL),
(170, '70000030', 'Esteban', 'Ruiz', 'DNI', NULL, 30, 'Jr. Salaverry 1616', '987654350', 1, NULL),
(171, '70000031', 'Paola', 'Zambrano', 'DNI', NULL, 31, 'Av. Néstor Gambetta 1717', '987654351', 1, NULL),
(172, '70000032', 'Tomás', 'Cabrera', 'DNI', NULL, 32, 'Av. Mi Perú 1818', '987654352', 1, NULL),
(173, '70000033', 'Gabriela', 'Mendoza', 'DNI', NULL, 5, 'Av. Venezuela 1919', '987654353', 1, NULL),
(174, '70000034', 'Andrés', 'Silva', 'DNI', NULL, 8, 'Jr. Sucre 2020', '987654354', 1, NULL),
(175, '70000035', 'Melissa', 'Quispe', 'DNI', NULL, 12, 'Calle Real 2121', '987654355', 1, NULL),
(176, '70000036', 'Alan', 'Castañeda', 'DNI', NULL, 15, 'Av. Javier Prado 2222', '987654356', 1, NULL),
(177, '70000037', 'Fiorella', 'León', 'DNI', NULL, 3, 'Calle Primavera 2323', '987654357', 1, NULL),
(178, '70000038', 'Rodrigo', 'Vargas', 'DNI', NULL, 9, 'Av. Las Torres 2424', '987654358', 1, NULL),
(179, '70000039', 'Patricia', 'Barreto', 'DNI', NULL, 14, 'Jr. Arica 2525', '987654359', 1, NULL),
(180, '70000040', 'Kevin', 'Alfaro', 'DNI', NULL, 19, 'Calle 28 de Julio 2626', '987654360', 1, NULL),
(181, '70000041', 'Mónica', 'Espinoza', 'DNI', NULL, 21, 'Av. Grau 2727', '987654361', 1, NULL),
(182, '70000042', 'Enrique', 'Solís', 'DNI', NULL, 11, 'Jr. Lima 2828', '987654362', 1, NULL),
(183, '70000043', 'Lorena', 'Velásquez', 'DNI', NULL, 6, 'Av. Trapiche 2929', '987654363', 1, NULL),
(184, '70000044', 'Álvaro', 'Cornejo', 'DNI', NULL, 13, 'Jr. Puno 3030', '987654364', 1, NULL),
(185, '70000045', 'Daniela', 'Del Carpio', 'DNI', NULL, 7, 'Av. Las Palmeras 3131', '987654365', 1, NULL),
(186, '70000046', 'Bruno', 'Galván', 'DNI', NULL, 18, 'Jr. José Olaya 3232', '987654366', 1, NULL),
(187, '70000047', 'Luisa', 'Gómez', 'DNI', NULL, 20, 'Av. Ejército 3333', '987654367', 1, NULL),
(188, '70000048', 'César', 'Ríos', 'DNI', NULL, 22, 'Calle Comercio 3434', '987654368', 1, NULL),
(189, '70000050', 'Sebastián', 'Cáceres', 'DNI', NULL, 27, 'Jr. Talara 3636', '9876543444', 1, NULL),
(190, '74372087', 'Amet Marcelo', 'Quispe Espichan', 'DNI', 'quispeamet2@gmail.com', 27, 'C. las azucenas', '931262732', 1, NULL),
(191, '47897897', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 9, 'Calle los Jazminez156', '9876543444', 1, NULL),
(192, '41414141', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 11, 'Calle los Jazminez156', '9876543444', 1, NULL),
(193, '45612345', 'Carlos', 'Martinez Martinez', 'DNI', 'cmartinez@gmail.com', 2, 'Calle los Jazminez 12', '965789789', 1, NULL),
(194, '70000001', 'Luis', 'Vargas', 'DNI', NULL, 1, 'Av. Arequipa 123', '987654321', 1, NULL),
(195, '70000002', 'Ana', 'Pérez', 'DNI', NULL, 2, 'Jr. Libertad 456', '987654322', 1, NULL),
(196, '70000003', 'Carlos', 'Ramírez', 'DNI', NULL, 3, 'Av. Metropolitana 789', '987654323', 1, NULL),
(197, '70000004', 'María', 'Gonzales', 'DNI', NULL, 4, 'Calle Italia 234', '987654324', 1, NULL),
(198, '70000005', 'José', 'López', 'DNI', NULL, 5, 'Av. Brasil 567', '987654325', 1, NULL),
(199, '70000006', 'Lucía', 'Torres', 'DNI', NULL, 6, 'Av. Túpac Amaru 890', '987654326', 1, NULL),
(200, '70000007', 'Javier', 'Morales', 'DNI', NULL, 7, 'Jr. Los Álamos 101', '987654327', 1, NULL),
(201, '70000008', 'Diana', 'Fernández', 'DNI', NULL, 8, 'Av. Huaylas 202', '987654328', 1, NULL),
(202, '70000009', 'Renato', 'Sánchez', 'DNI', NULL, 9, 'Calle Sol Naciente 303', '987654329', 1, NULL),
(203, '70000010', 'Sofía', 'Martínez', 'DNI', NULL, 10, 'Av. Universitaria 404', '987654330', 1, NULL),
(204, '70000011', 'Pedro', 'Salas', 'DNI', NULL, 11, 'Jr. César Vallejo 505', '987654331', 1, NULL),
(205, '70000012', 'Carmen', 'Cruz', 'DNI', NULL, 12, 'Av. Tomás Valle 606', '987654332', 1, NULL),
(206, '70000013', 'Héctor', 'Navarro', 'DNI', NULL, 13, 'Calle Tarata 707', '987654333', 1, NULL),
(207, '70000014', 'Vanessa', 'Reyes', 'DNI', NULL, 14, 'Av. Flora Tristán 808', '987654334', 1, NULL),
(208, '70000015', 'Jorge', 'Ibáñez', 'DNI', NULL, 15, 'Jr. Gamarra 909', '987654335', 1, NULL),
(209, '70000016', 'Natalia', 'Pacheco', 'DNI', NULL, 16, 'Av. Canevaro 111', '987654336', 1, NULL),
(210, '70000017', 'Diego', 'Ortega', 'DNI', NULL, 17, 'Calle Los Jazmines 222', '987654337', 1, NULL),
(211, '70000018', 'Andrea', 'Luna', 'DNI', NULL, 18, 'Av. Wiesse 333', '987654338', 1, NULL),
(212, '70000019', 'Martín', 'Camacho', 'DNI', NULL, 19, 'Jr. Los Olivos 444', '987654339', 1, NULL),
(213, '70000020', 'Rosa', 'Aguilar', 'DNI', NULL, 20, 'Av. Brasil 555', '987654340', 1, NULL),
(214, '70000021', 'Oscar', 'Delgado', 'DNI', NULL, 21, 'Av. Larco 666', '987654341', 1, NULL),
(215, '70000022', 'Julia', 'Montoya', 'DNI', NULL, 22, 'Calle Primavera 777', '987654342', 1, NULL),
(216, '70000023', 'Ángel', 'Soto', 'DNI', NULL, 23, 'Av. Malecon 888', '987654343', 1, NULL),
(217, '70000024', 'Claudia', 'Mejía', 'DNI', NULL, 24, 'Jr. Zarumilla 999', '987654344', 1, NULL),
(218, '70000025', 'Fernando', 'Gamarra', 'DNI', NULL, 25, 'Av. Alcázar 1110', '987654345', 1, NULL),
(219, '70000026', 'Tatiana', 'Rosales', 'DNI', NULL, 26, 'Calle 2 de Mayo 1212', '987654346', 1, NULL),
(220, '70000027', 'Iván', 'Villanueva', 'DNI', NULL, 27, 'Jr. América 1313', '987654347', 1, NULL),
(221, '70000028', 'Camila', 'Rivas', 'DNI', NULL, 28, 'Av. Colonial 1414', '987654348', 1, NULL),
(222, '70000029', 'Cristina', 'Becerra', 'DNI', NULL, 29, 'Calle San Martín 1515', '987654349', 1, NULL),
(223, '70000030', 'Esteban', 'Ruiz', 'DNI', NULL, 30, 'Jr. Salaverry 1616', '987654350', 1, NULL),
(224, '70000031', 'Paola', 'Zambrano', 'DNI', NULL, 31, 'Av. Néstor Gambetta 1717', '987654351', 1, NULL),
(225, '70000032', 'Tomás', 'Cabrera', 'DNI', NULL, 32, 'Av. Mi Perú 1818', '987654352', 1, NULL),
(226, '70000033', 'Gabriela', 'Mendoza', 'DNI', NULL, 5, 'Av. Venezuela 1919', '987654353', 1, NULL),
(227, '70000034', 'Andrés', 'Silva', 'DNI', NULL, 8, 'Jr. Sucre 2020', '987654354', 1, NULL),
(228, '70000035', 'Melissa', 'Quispe', 'DNI', NULL, 12, 'Calle Real 2121', '987654355', 1, NULL),
(229, '70000036', 'Alan', 'Castañeda', 'DNI', NULL, 15, 'Av. Javier Prado 2222', '987654356', 1, NULL),
(230, '70000037', 'Fiorella', 'León', 'DNI', NULL, 3, 'Calle Primavera 2323', '987654357', 1, NULL),
(231, '70000038', 'Rodrigo', 'Vargas', 'DNI', NULL, 9, 'Av. Las Torres 2424', '987654358', 1, NULL),
(232, '70000039', 'Patricia', 'Barreto', 'DNI', NULL, 14, 'Jr. Arica 2525', '987654359', 1, NULL),
(233, '70000040', 'Kevin', 'Alfaro', 'DNI', NULL, 19, 'Calle 28 de Julio 2626', '987654360', 1, NULL),
(234, '70000041', 'Mónica', 'Espinoza', 'DNI', NULL, 21, 'Av. Grau 2727', '987654361', 1, NULL),
(235, '70000042', 'Enrique', 'Solís', 'DNI', NULL, 11, 'Jr. Lima 2828', '987654362', 1, NULL),
(236, '70000043', 'Lorena', 'Velásquez', 'DNI', NULL, 6, 'Av. Trapiche 2929', '987654363', 1, NULL),
(237, '70000044', 'Álvaro', 'Cornejo', 'DNI', NULL, 13, 'Jr. Puno 3030', '987654364', 1, NULL),
(238, '70000045', 'Daniela', 'Del Carpio', 'DNI', NULL, 7, 'Av. Las Palmeras 3131', '987654365', 1, NULL),
(239, '70000046', 'Bruno', 'Galván', 'DNI', NULL, 18, 'Jr. José Olaya 3232', '987654366', 1, NULL),
(240, '70000047', 'Luisa', 'Gómez', 'DNI', NULL, 20, 'Av. Ejército 3333', '987654367', 1, NULL),
(241, '70000048', 'César', 'Ríos', 'DNI', NULL, 22, 'Calle Comercio 3434', '987654368', 1, NULL),
(242, '70000050', 'Sebastián', 'Cáceres', 'DNI', NULL, 27, 'Jr. Talara 3636', '9876543444', 1, NULL),
(243, '74372087', 'Amet Marcelo', 'Quispe Espichan', 'DNI', 'quispeamet2@gmail.com', 27, 'C. las azucenas', '931262732', 1, NULL),
(244, '47897897', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 9, 'Calle los Jazminez156', '9876543444', 1, NULL),
(245, '41414141', 'Juan', 'Sandoval', 'DNI', 'perez@gmail.com', 11, 'Calle los Jazminez156', '9876543444', 1, NULL),
(246, '45612345', 'Carlos', 'Martinez Martinez', 'DNI', 'cmartinez@gmail.com', 2, 'Calle los Jazminez 12', '965789789', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones_estados`
--

CREATE TABLE `cotizaciones_estados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizaciones_estados`
--

INSERT INTO `cotizaciones_estados` (`id`, `nombre`) VALUES
(6, 'Anulada'),
(3, 'Aprobada'),
(5, 'Caducada'),
(2, 'Enviada'),
(7, 'Pagado'),
(1, 'Pendiente'),
(4, 'Rechazada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos`
--

CREATE TABLE `egresos` (
  `id` int(11) NOT NULL,
  `referencia` varchar(100) NOT NULL,
  `guia` varchar(100) NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `observacion` varchar(300) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `egresos`
--

INSERT INTO `egresos` (`id`, `referencia`, `guia`, `concepto`, `fecha`, `proveedor_id`, `total`, `observacion`, `activo`) VALUES
(1, 'REF001', 'GUIDE001', 'Compra de materiales de oficina', '2025-06-20', 1, 150.75, NULL, 1),
(2, 'REF002', 'GUIDE002', 'Servicio de consultoría', '2025-06-21', 2, 500.00, 'Proyecto X', 1),
(3, 'REF003', 'GUIDE003', 'Alquiler de equipos', '2025-06-22', 3, 250.00, NULL, 1),
(4, 'REF004', 'GUIDE004', 'Suministros de limpieza', '2025-06-23', 4, 75.20, NULL, 1),
(5, 'REF005', 'GUIDE005', 'Mantenimiento de software', '2025-06-24', 5, 300.00, 'Licencia anual', 1),
(6, 'REF006', 'GUIDE006', 'Gastos de viaje', '2025-06-25', 6, 120.50, 'Viaje de negocios', 1),
(7, 'REF007', 'GUIDE007', 'Publicidad en línea', '2025-06-26', 7, 400.00, NULL, 1),
(8, 'REF008', 'GUIDE008', 'Compra de equipos de TI', '2025-06-27', 1, 800.00, NULL, 1),
(9, 'REF009', 'GUIDE009', 'Material de marketing', '2025-06-28', 2, 90.00, NULL, 1),
(10, 'REF010', 'GUIDE010', 'Servicios de seguridad', '2025-06-29', 3, 350.00, NULL, 1),
(11, 'REF011', 'GUIDE011', 'Capacitación de personal', '2025-07-01', 4, 600.00, NULL, 1),
(12, 'REF012', 'GUIDE012', 'Reparación de vehículos', '2025-07-02', 5, 180.00, NULL, 1),
(13, 'REF013', 'GUIDE013', 'Material de embalaje', '2025-07-03', 6, 50.00, NULL, 1),
(14, 'REF014', 'GUIDE014', 'Servicios legales', '2025-07-04', 7, 700.00, 'Asesoría contrato', 1),
(15, 'REF015', 'GUIDE015', 'Desarrollo de software', '2025-07-05', 1, 1200.00, 'Fase 1', 1),
(16, 'REF016', 'GUIDE016', 'Insumos de cafetería', '2025-07-06', 2, 45.00, NULL, 1),
(17, 'REF017', 'GUIDE017', 'Arrendamiento de local', '2025-07-07', 3, 1500.00, NULL, 1),
(18, 'REF018', 'GUIDE018', 'Servicios de jardinería', '2025-07-08', 4, 100.00, NULL, 1),
(19, 'REF019', 'GUIDE019', 'Suscripción a revista especializada', '2025-07-09', 5, 80.00, NULL, 1),
(20, 'REF020', 'GUIDE020', 'Conectividad a internet', '2025-07-10', 6, 95.00, NULL, 1),
(21, 'REF021', 'GUIDE021', 'Gastos de envío', '2025-07-11', 7, 30.00, NULL, 1),
(22, 'REF022', 'GUIDE022', 'Material didáctico', '2025-07-12', 1, 110.00, NULL, 1),
(23, 'REF023', 'GUIDE023', 'Servicios de traducción', '2025-07-13', 2, 200.00, NULL, 1),
(24, 'REF024', 'GUIDE024', 'Mobiliario de oficina', '2025-07-14', 3, 550.00, NULL, 1),
(25, 'REF025', 'GUIDE025', 'Licencias de software', '2025-07-15', 4, 900.00, NULL, 1),
(26, 'REF026', 'GUIDE026', 'Combustible', '2025-07-16', 5, 60.00, NULL, 1),
(27, 'REF027', 'GUIDE027', 'Gastos de representación', '2025-07-17', 6, 220.00, NULL, 1),
(28, 'REF028', 'GUIDE028', 'Servicios de imprenta', '2025-07-18', 7, 130.00, NULL, 1),
(29, 'REF029', 'GUIDE029', 'Repuestos para maquinaria', '2025-07-19', 1, 450.00, NULL, 1),
(30, 'REF030', 'GUIDE030', 'Honorarios profesionales', '2025-07-20', 2, 750.00, NULL, 1),
(31, 'REF031', 'GUIDE031', 'Gastos de viajes corporativos', '2025-07-21', 3, 800.00, 'Conferencia anual', 1),
(32, 'REF032', 'GUIDE032', 'Publicidad en radio', '2025-07-22', 4, 300.00, NULL, 1),
(33, 'REF033', 'GUIDE033', 'Compra de herramientas', '2025-07-23', 5, 170.00, NULL, 1),
(34, 'REF034', 'GUIDE034', 'Material de seguridad', '2025-07-24', 6, 90.00, NULL, 1),
(35, 'REF035', 'GUIDE035', 'Servicios de mensajería', '2025-07-25', 7, 40.00, NULL, 1),
(36, 'REF036', 'GUIDE036', 'Actualización de sistemas', '2025-07-26', 1, 600.00, NULL, 1),
(37, 'REF037', 'GUIDE037', 'Material de papelería', '2025-07-27', 2, 65.00, NULL, 1),
(38, 'REF038', 'GUIDE038', 'Servicios de limpieza especializados', '2025-07-28', 3, 200.00, NULL, 1),
(39, 'REF039', 'GUIDE039', 'Gastos de capacitación online', '2025-07-29', 4, 150.00, NULL, 1),
(40, 'REF040', 'GUIDE040', 'Alquiler de vehículos', '2025-07-30', 5, 280.00, NULL, 1),
(41, 'REF041', 'GUIDE041', 'Servicios de mantenimiento preventivo', '2025-07-31', 6, 320.00, NULL, 1),
(42, 'REF042', 'GUIDE042', 'Publicidad en redes sociales', '2025-08-01', 7, 180.00, NULL, 1),
(43, 'REF043', 'GUIDE043', 'Compra de licencias antivirus', '2025-08-02', 1, 100.00, NULL, 1),
(44, 'REF044', 'GUIDE044', 'Servicios de fotografía', '2025-08-03', 2, 250.00, NULL, 1),
(45, 'REF045', 'GUIDE045', 'Material de primeros auxilios', '2025-08-04', 3, 50.00, NULL, 1),
(46, 'REF046', 'GUIDE046', 'Reparación de equipos de oficina', '2025-08-05', 4, 120.00, NULL, 1),
(47, 'REF047', 'GUIDE047', 'Gastos de mensajería internacional', '2025-08-06', 5, 70.00, NULL, 1),
(48, 'REF048', 'GUIDE048', 'Asesoría fiscal', '2025-08-07', 6, 400.00, NULL, 1),
(49, 'REF049', 'GUIDE049', 'Insumos de impresión', '2025-08-08', 7, 90.00, NULL, 1),
(50, 'REF050', 'GUIDE050', 'Servicios de auditoría', '2025-08-09', 1, 900.00, NULL, 1),
(51, 'REF051', 'GUIDE051', 'Compra de material promocional', '2025-08-10', 2, 160.00, NULL, 1),
(52, 'REF052', 'GUIDE052', 'Servicios de catering', '2025-08-11', 3, 300.00, NULL, 1),
(53, 'REF053', 'GUIDE053', 'Mantenimiento de aire acondicionado', '2025-08-12', 4, 140.00, NULL, 1),
(54, 'REF054', 'GUIDE054', 'Gastos de eventos corporativos', '2025-08-13', 5, 700.00, 'Fiesta de fin de año', 1),
(55, 'REF055', 'GUIDE055', 'Suscripción a base de datos', '2025-08-14', 6, 250.00, NULL, 1),
(56, 'REF056', 'GUIDE056', 'Servicios de traducción de documentos', '2025-08-15', 7, 180.00, NULL, 1),
(57, 'REF057', 'GUIDE057', 'Compra de software de diseño', '2025-08-16', 1, 500.00, NULL, 1),
(58, 'REF058', 'GUIDE058', 'Material de empaque personalizado', '2025-08-17', 2, 110.00, NULL, 1),
(59, 'REF059', 'GUIDE059', 'Reparación de fontanería', '2025-08-18', 3, 85.00, NULL, 1),
(60, 'REF060', 'GUIDE060', 'Servicios de desarrollo web', '2025-08-19', 4, 1500.00, 'Actualización de sitio', 1),
(61, 'REF061', 'GUIDE061', 'Combustible para generador', '2025-08-20', 5, 75.00, NULL, 1),
(62, 'REF062', 'GUIDE062', 'Material de electricidad', '2025-08-21', 6, 95.00, NULL, 1),
(63, 'REF063', 'GUIDE063', 'Servicios de consultoría de TI', '2025-08-22', 7, 1100.00, NULL, 1),
(64, 'REF064', 'GUIDE064', 'Gastos de viajes del personal', '2025-08-23', 1, 350.00, NULL, 1),
(65, 'REF065', 'GUIDE065', 'Publicidad en televisión local', '2025-08-24', 2, 800.00, NULL, 1),
(66, 'REF066', 'GUIDE066', 'Compra de equipo de seguridad', '2025-08-25', 3, 220.00, NULL, 1),
(67, 'REF067', 'GUIDE067', 'Material de señalización', '2025-08-26', 4, 60.00, NULL, 1),
(68, 'REF068', 'GUIDE068', 'Servicios de limpieza de cristales', '2025-08-27', 5, 130.00, NULL, 1),
(69, 'REF069', 'GUIDE069', 'Mantenimiento de sistemas de seguridad', '2025-08-28', 6, 280.00, NULL, 1),
(70, 'REF070', 'GUIDE070', 'Gastos de envío urgente', '2025-08-29', 7, 45.00, NULL, 1),
(71, 'REF071', 'GUIDE071', 'Compra de mobiliario ergonómico', '2025-08-30', 1, 650.00, NULL, 1),
(72, 'REF072', 'GUIDE072', 'Servicios de telemarketing', '2025-08-31', 2, 300.00, NULL, 1),
(73, 'REF073', 'GUIDE073', 'Material de laboratorio', '2025-09-01', 3, 190.00, NULL, 1),
(74, 'REF074', 'GUIDE074', 'Reparación de tejado', '2025-09-02', 4, 400.00, NULL, 1),
(75, 'REF075', 'GUIDE075', 'Servicios de consultoría de marketing', '2025-09-03', 5, 900.00, NULL, 1),
(76, 'REF076', 'GUIDE076', 'Material de ferretería', '2025-09-04', 6, 70.00, NULL, 1),
(77, 'REF077', 'GUIDE077', 'Gastos de formación y desarrollo', '2025-09-05', 7, 500.00, NULL, 1),
(78, 'REF078', 'GUIDE078', 'Publicidad en revistas especializadas', '2025-09-06', 1, 250.00, NULL, 1),
(79, 'REF079', 'GUIDE079', 'Compra de sistemas de alarmas', '2025-09-07', 2, 600.00, NULL, 1),
(80, 'REF080', 'GUIDE080', 'Servicios de desinfección', '2025-09-08', 3, 150.00, NULL, 1),
(81, 'REF081', 'GUIDE081', 'Material de oficina reciclado', '2025-09-09', 4, 80.00, NULL, 1),
(82, 'REF082', 'GUIDE082', 'Mantenimiento de ascensores', '2025-09-10', 5, 200.00, NULL, 1),
(83, 'REF083', 'GUIDE083', 'Gastos de representación de clientes', '2025-09-11', 6, 320.00, NULL, 1),
(84, 'REF084', 'GUIDE084', 'Servicios de asesoría laboral', '2025-09-12', 7, 550.00, NULL, 1),
(85, 'REF085', 'GUIDE085', 'Compra de equipos de video conferencia', '2025-09-13', 1, 700.00, NULL, 1),
(86, 'REF086', 'GUIDE086', 'Material de jardinería', '2025-09-14', 2, 40.00, NULL, 1),
(87, 'REF087', 'GUIDE087', 'Reparación de sistemas eléctricos', '2025-09-15', 3, 280.00, NULL, 1),
(88, 'REF088', 'GUIDE088', 'Servicios de gestión de redes sociales', '2025-09-16', 4, 380.00, NULL, 1),
(89, 'REF089', 'GUIDE089', 'Licencias de antivirus y seguridad', '2025-09-17', 5, 120.00, NULL, 1),
(90, 'REF090', 'GUIDE090', 'Gastos de envío de muestras', '2025-09-18', 6, 60.00, NULL, 1),
(91, 'REF091', 'GUIDE091', 'Servicios de consultoría de procesos', '2025-09-19', 7, 1000.00, NULL, 1),
(92, 'REF092', 'GUIDE092', 'Compra de material de fontanería', '2025-09-20', 1, 90.00, NULL, 1),
(93, 'REF093', 'GUIDE093', 'Mantenimiento de infraestructura', '2025-09-21', 2, 450.00, NULL, 1),
(94, 'REF094', 'GUIDE094', 'Servicios de copias e impresiones', '2025-09-22', 3, 75.00, NULL, 1),
(95, 'REF095', 'GUIDE095', 'Gastos de teletrabajo (internet, luz)', '2025-09-23', 4, 180.00, NULL, 1),
(96, 'REF096', 'GUIDE096', 'Publicidad en medios digitales', '2025-09-24', 5, 600.00, NULL, 1),
(97, 'REF097', 'GUIDE097', 'Compra de insumos de cafetería a granel', '2025-09-25', 6, 110.00, NULL, 1),
(98, 'REF098', 'GUIDE098', 'Servicios de auditoría interna', '2025-09-26', 7, 800.00, NULL, 1),
(99, 'REF099', 'GUIDE099', 'Material de embalaje especial', '2025-09-27', 1, 140.00, NULL, 1),
(100, 'REF100', 'GUIDE100', 'Renovación de licencias de software', '2025-09-28', 2, 1000.00, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `egresos_productos`
--

CREATE TABLE `egresos_productos` (
  `id` int(11) NOT NULL,
  `egreso_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `egresos_productos`
--

INSERT INTO `egresos_productos` (`id`, `egreso_id`, `producto_id`, `cantidad`, `costo`, `total`) VALUES
(1, 1, 4, 1, 12.00, 12.00),
(2, 1, 8, 2, 18.00, 36.00),
(3, 2, 20, 1, 28.00, 28.00),
(4, 3, 6, 10, 4.50, 45.00),
(5, 4, 2, 1, 7.50, 7.50),
(6, 5, 17, 1, 70.00, 70.00),
(7, 6, 6, 5, 4.50, 22.50),
(8, 7, 20, 1, 28.00, 28.00),
(9, 8, 5, 3, 35.00, 105.00),
(10, 9, 14, 2, 40.00, 80.00),
(11, 10, 6, 10, 4.50, 45.00),
(12, 11, 19, 1, 80.00, 80.00),
(13, 12, 9, 1, 38.00, 38.00),
(14, 13, 6, 15, 4.50, 67.50),
(15, 14, 2, 1, 7.50, 7.50),
(16, 15, 8, 1, 18.00, 18.00),
(17, 16, 4, 1, 12.00, 12.00),
(18, 17, 1, 2, 18.00, 36.00),
(19, 18, 3, 5, 6.00, 30.00),
(20, 19, 7, 1, 50.00, 50.00),
(21, 20, 12, 2, 9.00, 18.00),
(22, 21, 10, 1, 15.00, 15.00),
(23, 22, 15, 1, 100.00, 100.00),
(24, 23, 16, 1, 75.00, 75.00),
(25, 24, 18, 1, 120.00, 120.00),
(26, 25, 4, 1, 12.00, 12.00),
(27, 26, 8, 2, 18.00, 36.00),
(28, 27, 20, 1, 28.00, 28.00),
(29, 28, 6, 10, 4.50, 45.00),
(30, 29, 2, 1, 7.50, 7.50),
(31, 30, 17, 1, 70.00, 70.00),
(32, 31, 6, 5, 4.50, 22.50),
(33, 32, 20, 1, 28.00, 28.00),
(34, 33, 5, 3, 35.00, 105.00),
(35, 34, 14, 2, 40.00, 80.00),
(36, 35, 6, 10, 4.50, 45.00),
(37, 36, 19, 1, 80.00, 80.00),
(38, 37, 9, 1, 38.00, 38.00),
(39, 38, 6, 15, 4.50, 67.50),
(40, 39, 2, 1, 7.50, 7.50),
(41, 40, 8, 1, 18.00, 18.00),
(42, 41, 4, 1, 12.00, 12.00),
(43, 42, 1, 2, 18.00, 36.00),
(44, 43, 3, 5, 6.00, 30.00),
(45, 44, 7, 1, 50.00, 50.00),
(46, 45, 12, 2, 9.00, 18.00),
(47, 46, 10, 1, 15.00, 15.00),
(48, 47, 15, 1, 100.00, 100.00),
(49, 48, 16, 1, 75.00, 75.00),
(50, 49, 18, 1, 120.00, 120.00),
(51, 50, 4, 1, 12.00, 12.00),
(52, 51, 8, 2, 18.00, 36.00),
(53, 52, 20, 1, 28.00, 28.00),
(54, 53, 6, 10, 4.50, 45.00),
(55, 54, 2, 1, 7.50, 7.50),
(56, 55, 17, 1, 70.00, 70.00),
(57, 56, 6, 5, 4.50, 22.50),
(58, 57, 20, 1, 28.00, 28.00),
(59, 58, 5, 3, 35.00, 105.00),
(60, 59, 14, 2, 40.00, 80.00),
(61, 60, 6, 10, 4.50, 45.00),
(62, 61, 19, 1, 80.00, 80.00),
(63, 62, 9, 1, 38.00, 38.00),
(64, 63, 6, 15, 4.50, 67.50),
(65, 64, 2, 1, 7.50, 7.50),
(66, 65, 8, 1, 18.00, 18.00),
(67, 66, 4, 1, 12.00, 12.00),
(68, 67, 1, 2, 18.00, 36.00),
(69, 68, 3, 5, 6.00, 30.00),
(70, 69, 7, 1, 50.00, 50.00),
(71, 70, 12, 2, 9.00, 18.00),
(72, 71, 10, 1, 15.00, 15.00),
(73, 72, 15, 1, 100.00, 100.00),
(74, 73, 16, 1, 75.00, 75.00),
(75, 74, 18, 1, 120.00, 120.00),
(76, 75, 4, 1, 12.00, 12.00),
(77, 76, 8, 2, 18.00, 36.00),
(78, 77, 20, 1, 28.00, 28.00),
(79, 78, 6, 10, 4.50, 45.00),
(80, 79, 2, 1, 7.50, 7.50),
(81, 80, 17, 1, 70.00, 70.00),
(82, 81, 6, 5, 4.50, 22.50),
(83, 82, 20, 1, 28.00, 28.00),
(84, 83, 5, 3, 35.00, 105.00),
(85, 84, 14, 2, 40.00, 80.00),
(86, 85, 6, 10, 4.50, 45.00),
(87, 86, 19, 1, 80.00, 80.00),
(88, 87, 9, 1, 38.00, 38.00),
(89, 88, 6, 15, 4.50, 67.50),
(90, 89, 2, 1, 7.50, 7.50),
(91, 90, 8, 1, 18.00, 18.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadosordenes`
--

CREATE TABLE `estadosordenes` (
  `id` int(11) NOT NULL,
  `estado_orden` varchar(50) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estadosordenes`
--

INSERT INTO `estadosordenes` (`id`, `estado_orden`, `activo`) VALUES
(1, 'Pendiente', 1),
(2, 'En curso', 1),
(3, 'Finalizado', 1),
(4, 'Cancelado', 1),
(5, 'Pendiente', 1),
(6, 'En curso', 1),
(7, 'Finalizado', 1),
(8, 'Cancelado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos`
--

CREATE TABLE `ingresos` (
  `id` int(11) NOT NULL,
  `referencia` varchar(100) NOT NULL,
  `guia` varchar(100) NOT NULL,
  `concepto` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `observacion` varchar(300) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingresos`
--

INSERT INTO `ingresos` (`id`, `referencia`, `guia`, `concepto`, `fecha`, `proveedor_id`, `total`, `observacion`, `activo`) VALUES
(1, 'REF001', 'GUIA001', 'Compra de herramientas', '2025-06-05', 1, 1000.00, 'Primera compra', 1),
(2, 'REF002', 'GUIA002', 'Compra de repuestos', '2025-06-05', 2, 1500.00, 'Segunda compra', 1),
(3, 'REF003', 'GUIA003', 'Compra de lubricantes', '2025-06-05', 1, 800.00, 'Tercera compra', 1),
(4, 'F001-00001515', 'GUI-0000003', 'COMPRA', '2025-06-08', 1, 0.00, '.', 1),
(5, 'F001-00001516', 'GUI-0000004', 'COMPRA', '2025-06-08', 2, 0.00, '.', 1),
(6, 'F001-00001517', 'GUI-0000005', 'COMPRA', '2025-06-08', 2, 0.00, '.', 1),
(7, 'F001-00001518', 'GUI-0000006', 'COMPRA', '2025-06-08', 1, 0.00, '.', 1),
(11, 'F001-00001520', 'GUI-0000008', 'COMPRA', '2025-06-08', 2, 1650.00, '.', 0),
(12, 'F001-00001521', 'GUI-0000009', 'COMPRA', '2025-06-08', 1, 300.00, '.', 1),
(13, 'F001-00001522', 'GUI-00000010', 'COMPRA', '2025-06-08', 1, 275.00, '.', 1),
(14, 'F001-00001523', 'GUI-00000011', 'COMPRA', '2025-06-08', 1, 455.00, '.', 0),
(15, 'F001-00001524', 'GUI-00000012', 'COMPRA', '2025-06-08', 2, 90.00, '.', 1),
(16, 'F001-00001525', 'GUI-00000013', 'COMPRA', '2025-06-08', 1, 500.00, '.', 1),
(17, 'F001-00001527', 'GUI-00000015', 'COMPRA', '2025-06-08', 1, 150.00, '.', 1),
(18, 'F001-00001528', 'GUI-00000016', 'COMPRA', '2025-06-08', 2, 80.00, '.', 0),
(19, 'F001-00001528', 'I001-00000001', 'COMPRA', '2025-06-08', 2, 60.00, '.', 1),
(20, 'F001-00001522', 'I001-00000002', 'COMPRA', '2025-06-08', 1, 100.00, '.', 1),
(21, 'F001-00001521', 'I001-00000003', 'COMPRA', '2025-06-08', 1, 130.00, '.', 1),
(22, 'F001-00001522', 'I001-00000004', 'COMPRA', '2025-06-08', 2, 150.00, '.', 1),
(23, 'F001-00001523', 'I001-00000005', 'COMPRA', '2025-06-10', 2, 114.00, '.', 0),
(24, 'F001-00001529', 'I001-00000006', 'COMPRA', '2025-06-11', 1, 1750.00, '.', 1),
(25, 'F001-00001529', 'I001-00000007', 'COMPRA', '2025-06-17', 3, 0.00, '.', 1),
(26, 'F001-00001530', 'I001-00000008', 'COMPRA', '2025-06-17', 2, 750.00, '.', 1),
(27, 'F001-00001531', 'I001-00000009', 'COMPRA', '2025-06-17', 1, 300.00, '.', 0),
(28, 'F001-00001560', 'I001-00000010', 'COMPRA', '2025-06-26', 3, 50.00, '.', 1),
(29, 'F001-00001561', 'I001-00000011', 'COMPRA', '2025-06-26', 2, 1000.00, '.', 1),
(30, 'REF001', 'GUIA001', 'Compra de herramientas', '2025-06-05', 1, 1000.00, 'Primera compra', 1),
(31, 'REF002', 'GUIA002', 'Compra de repuestos', '2025-06-05', 2, 1500.00, 'Segunda compra', 1),
(32, 'REF003', 'GUIA003', 'Compra de lubricantes', '2025-06-05', 1, 800.00, 'Tercera compra', 1),
(33, 'F001-00001515', 'GUI-0000003', 'COMPRA', '2025-06-08', 1, 0.00, '.', 1),
(34, 'F001-00001516', 'GUI-0000004', 'COMPRA', '2025-06-08', 2, 0.00, '.', 1),
(35, 'F001-00001517', 'GUI-0000005', 'COMPRA', '2025-06-08', 2, 0.00, '.', 1),
(36, 'F001-00001518', 'GUI-0000006', 'COMPRA', '2025-06-08', 1, 0.00, '.', 1),
(37, 'F001-00001520', 'GUI-0000008', 'COMPRA', '2025-06-08', 2, 1650.00, '.', 0),
(38, 'F001-00001521', 'GUI-0000009', 'COMPRA', '2025-06-08', 1, 300.00, '.', 1),
(39, 'F001-00001522', 'GUI-00000010', 'COMPRA', '2025-06-08', 1, 275.00, '.', 1),
(40, 'F001-00001523', 'GUI-00000011', 'COMPRA', '2025-06-08', 1, 455.00, '.', 0),
(41, 'F001-00001524', 'GUI-00000012', 'COMPRA', '2025-06-08', 2, 90.00, '.', 1),
(42, 'F001-00001525', 'GUI-00000013', 'COMPRA', '2025-06-08', 1, 500.00, '.', 1),
(43, 'F001-00001527', 'GUI-00000015', 'COMPRA', '2025-06-08', 1, 150.00, '.', 1),
(44, 'F001-00001528', 'GUI-00000016', 'COMPRA', '2025-06-08', 2, 80.00, '.', 0),
(45, 'F001-00001528', 'I001-00000001', 'COMPRA', '2025-06-08', 2, 60.00, '.', 1),
(46, 'F001-00001522', 'I001-00000002', 'COMPRA', '2025-06-08', 1, 100.00, '.', 1),
(47, 'F001-00001521', 'I001-00000003', 'COMPRA', '2025-06-08', 1, 130.00, '.', 1),
(48, 'F001-00001522', 'I001-00000004', 'COMPRA', '2025-06-08', 2, 150.00, '.', 1),
(49, 'F001-00001523', 'I001-00000005', 'COMPRA', '2025-06-10', 2, 114.00, '.', 0),
(50, 'F001-00001529', 'I001-00000006', 'COMPRA', '2025-06-11', 1, 1750.00, '.', 1),
(51, 'F001-00001529', 'I001-00000007', 'COMPRA', '2025-06-17', 3, 0.00, '.', 1),
(52, 'F001-00001530', 'I001-00000008', 'COMPRA', '2025-06-17', 2, 750.00, '.', 1),
(53, 'F001-00001531', 'I001-00000009', 'COMPRA', '2025-06-17', 1, 300.00, '.', 0),
(54, 'F001-00001560', 'I001-00000010', 'COMPRA', '2025-06-26', 3, 50.00, '.', 1),
(55, 'F001-00001561', 'I001-00000011', 'COMPRA', '2025-06-26', 2, 1000.00, '.', 1),
(56, 'F002-0000310', 'G002-0000450', 'COMPRA REPUESTOS VARIOS', '2025-07-10', 4, 4550.00, NULL, 1),
(57, 'B003-0000520', 'G003-0000680', 'COMPRA LUBRICANTES Y ADITIVOS', '2025-07-11', 5, 2950.00, NULL, 1),
(58, 'REF001', 'GUIA001', 'Compra de repuestos para motor', '2025-01-15', 4, 1500.50, 'Factura A123', 1),
(59, 'REF002', 'GUIA002', 'Adquisición de aceites y lubricantes', '2025-01-20', 5, 800.75, NULL, 1),
(60, 'REF003', 'GUIA003', 'Compra de accesorios para vehículos', '2025-02-01', 3, 300.00, 'Pagado con transferencia', 1),
(61, 'REF004', 'GUIA004', 'Suministro de neumáticos', '2025-02-10', 1, 2200.00, 'Orden de compra #12345', 1),
(62, 'REF005', 'GUIA005', 'Material de limpieza para taller', '2025-02-15', 2, 120.00, NULL, 1),
(63, 'REF006', 'GUIA006', 'Repuestos eléctricos', '2025-03-01', 17, 750.25, 'Pendiente de revisión de stock', 0),
(64, 'REF007', 'GUIA007', 'Herramientas y equipos varios', '2025-03-05', 4, 3500.00, 'Importación directa', 1),
(65, 'REF008', 'GUIA008', 'Filtros y elementos de mantenimiento', '2025-03-12', 5, 620.40, NULL, 1),
(66, 'REF009', 'GUIA009', 'Lámparas y luces LED', '2025-03-20', 1, 480.90, 'Descuento por volumen', 1),
(67, 'REF010', 'GUIA010', 'Compra de equipos de diagnóstico', '2025-04-01', 2, 4500.00, 'Financiado en 3 cuotas', 1),
(68, 'REF011', 'GUIA011', 'Insumos para pintura automotriz', '2025-04-05', 3, 900.10, NULL, 1),
(69, 'REF012', 'GUIA012', 'Sistemas de suspensión', '2025-04-10', 4, 1800.60, 'Pedido urgente', 1),
(70, 'REF013', 'GUIA013', 'Artículos de oficina', '2025-04-18', 2, 85.00, 'Para uso administrativo', 1),
(71, 'REF014', 'GUIA014', 'Líquidos y aditivos especiales', '2025-04-25', 5, 320.00, NULL, 0),
(72, 'REF015', 'GUIA015', 'Sensores y componentes electrónicos', '2025-05-02', 17, 1100.00, 'Revisar compatibilidad', 1),
(73, 'REF016', 'GUIA016', 'Piezas para sistemas de escape', '2025-05-08', 4, 670.30, NULL, 1),
(74, 'REF017', 'GUIA017', 'Tapicería y elementos interiores', '2025-05-15', 3, 400.00, 'Para proyectos personalizados', 1),
(75, 'REF018', 'GUIA018', 'Equipos de seguridad para taller', '2025-05-20', 1, 250.00, NULL, 1),
(76, 'REF019', 'GUIA019', 'Componentes de frenos', '2025-06-01', 2, 950.50, 'Factura pendiente', 1),
(77, 'REF020', 'GUIA020', 'Inventario inicial de productos varios', '2025-06-10', 5, 5000.00, 'Gran compra de inicio de mes', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingresos_productos`
--

CREATE TABLE `ingresos_productos` (
  `id` int(11) NOT NULL,
  `ingreso_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `costo` decimal(12,2) NOT NULL,
  `total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ingresos_productos`
--

INSERT INTO `ingresos_productos` (`id`, `ingreso_id`, `producto_id`, `cantidad`, `costo`, `total`) VALUES
(1, 1, 1, 10, 20.00, 200.00),
(2, 1, 2, 5, 30.00, 150.00),
(3, 1, 3, 8, 25.00, 200.00),
(4, 1, 4, 10, 45.00, 450.00),
(5, 11, 4, 150, 10.00, 1500.00),
(6, 11, 2, 15, 10.00, 150.00),
(7, 12, 8, 25, 12.00, 300.00),
(8, 13, 54, 5, 55.00, 275.00),
(9, 14, 1, 15, 12.00, 180.00),
(10, 14, 2, 25, 11.00, 275.00),
(11, 15, 1, 10, 9.00, 90.00),
(12, 16, 1, 50, 10.00, 500.00),
(13, 17, 2, 30, 5.00, 150.00),
(14, 18, 1, 10, 8.00, 80.00),
(15, 19, 3, 4, 15.00, 60.00),
(16, 20, 2, 10, 10.00, 100.00),
(17, 21, 8, 13, 10.00, 130.00),
(18, 22, 30, 10, 15.00, 150.00),
(19, 23, 15, 3, 9.00, 27.00),
(20, 23, 19, 3, 29.00, 87.00),
(21, 24, 14, 4, 250.00, 1000.00),
(22, 24, 10, 10, 75.00, 750.00),
(23, 26, 11, 10, 45.00, 450.00),
(24, 26, 24, 10, 30.00, 300.00),
(25, 27, 3, 20, 15.00, 300.00),
(26, 28, 4, 10, 5.00, 50.00),
(27, 29, 1, 100, 10.00, 1000.00),
(28, 1, 1, 10, 20.00, 200.00),
(29, 1, 2, 5, 30.00, 150.00),
(30, 1, 3, 8, 25.00, 200.00),
(31, 1, 4, 10, 45.00, 450.00),
(32, 11, 4, 150, 10.00, 1500.00),
(33, 11, 2, 15, 10.00, 150.00),
(34, 12, 8, 25, 12.00, 300.00),
(35, 13, 54, 5, 55.00, 275.00),
(36, 14, 1, 15, 12.00, 180.00),
(37, 14, 2, 25, 11.00, 275.00),
(38, 15, 1, 10, 9.00, 90.00),
(39, 16, 1, 50, 10.00, 500.00),
(40, 17, 2, 30, 5.00, 150.00),
(41, 18, 1, 10, 8.00, 80.00),
(42, 19, 3, 4, 15.00, 60.00),
(43, 20, 2, 10, 10.00, 100.00),
(44, 21, 8, 13, 10.00, 130.00),
(45, 22, 30, 10, 15.00, 150.00),
(46, 23, 15, 3, 9.00, 27.00),
(47, 23, 19, 3, 29.00, 87.00),
(48, 24, 14, 4, 250.00, 1000.00),
(49, 24, 10, 10, 75.00, 750.00),
(50, 26, 11, 10, 45.00, 450.00),
(51, 26, 24, 10, 30.00, 300.00),
(52, 27, 3, 20, 15.00, 300.00),
(53, 28, 4, 10, 5.00, 50.00),
(54, 29, 1, 100, 10.00, 1000.00),
(55, 30, 64, 10, 95.00, 950.00),
(56, 30, 62, 5, 280.00, 1400.00),
(57, 30, 11, 20, 35.00, 700.00),
(58, 31, 61, 50, 35.00, 1750.00),
(59, 30, 64, 20, 95.00, 1900.00),
(60, 30, 62, 5, 280.00, 1400.00),
(61, 30, 11, 20, 35.00, 700.00),
(62, 30, 63, 10, 55.00, 550.00),
(63, 31, 61, 50, 35.00, 1750.00),
(64, 31, 5, 30, 40.00, 1200.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `total_ingresos` int(11) DEFAULT 0,
  `total_egresos` int(11) DEFAULT 0,
  `total_ventas` int(11) DEFAULT 0,
  `stock` int(11) GENERATED ALWAYS AS (`total_ingresos` - `total_egresos` - `total_ventas`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id`, `producto_id`, `total_ingresos`, `total_egresos`, `total_ventas`) VALUES
(1, 1, 340, 0, 5),
(2, 2, 90, 0, 1),
(3, 3, 24, 0, 0),
(4, 4, 40, 0, 10),
(5, 8, 76, 0, 10),
(6, 54, 10, 0, 0),
(7, 5, 30, 0, 0),
(8, 6, 0, 0, 0),
(9, 7, 0, 0, 0),
(10, 9, 0, 0, 0),
(11, 10, 20, 0, 0),
(12, 11, 60, 0, 0),
(13, 12, 0, 0, 0),
(14, 13, 0, 0, 0),
(15, 14, 8, 0, 1),
(16, 15, 0, 0, 0),
(17, 16, 0, 0, 0),
(18, 17, 0, 0, 0),
(19, 18, 0, 0, 0),
(20, 19, 0, 0, 0),
(21, 20, 0, 0, 0),
(22, 21, 0, 0, 0),
(23, 22, 0, 0, 0),
(24, 23, 0, 0, 0),
(25, 24, 20, 0, 0),
(26, 25, 0, 0, 0),
(27, 26, 0, 0, 0),
(28, 27, 0, 0, 0),
(29, 28, 0, 0, 0),
(30, 29, 0, 0, 0),
(31, 30, 20, 0, 0),
(32, 31, 0, 0, 0),
(33, 32, 0, 0, 0),
(34, 33, 0, 0, 0),
(35, 34, 0, 0, 0),
(36, 35, 0, 0, 0),
(37, 36, 0, 0, 0),
(38, 37, 0, 0, 0),
(39, 38, 0, 0, 0),
(40, 39, 0, 0, 0),
(41, 40, 0, 0, 0),
(42, 41, 0, 0, 0),
(43, 42, 0, 0, 0),
(44, 43, 0, 0, 0),
(45, 44, 0, 0, 0),
(46, 45, 0, 0, 0),
(47, 46, 0, 0, 0),
(48, 47, 0, 0, 0),
(49, 48, 0, 0, 0),
(50, 49, 0, 0, 0),
(51, 50, 0, 0, 0),
(52, 55, 0, 0, 0),
(53, 56, 0, 0, 0),
(54, 57, 0, 0, 0),
(55, 59, 0, 0, 0),
(56, 60, 0, 0, 0),
(113, 61, 100, 0, 0),
(114, 62, 10, 0, 2),
(115, 63, 10, 0, 0),
(116, 64, 30, 0, 0),
(117, 61, 50, 0, 1),
(118, 62, 5, 0, 2),
(119, 63, 10, 0, 0),
(120, 64, 20, 0, 1),
(121, 65, 0, 0, 0),
(122, 66, 0, 0, 0),
(123, 67, 0, 0, 0),
(124, 68, 0, 0, 0),
(125, 69, 0, 0, 0),
(126, 70, 0, 0, 0),
(127, 71, 0, 0, 0),
(128, 72, 0, 0, 0),
(129, 73, 0, 0, 0),
(130, 74, 0, 0, 0),
(131, 75, 0, 0, 0),
(132, 76, 0, 0, 0),
(133, 77, 0, 0, 0),
(134, 78, 0, 0, 0),
(135, 79, 0, 0, 0),
(136, 80, 0, 0, 0),
(137, 81, 0, 0, 0),
(138, 82, 0, 0, 0),
(139, 83, 0, 0, 0),
(140, 84, 0, 0, 0),
(141, 85, 0, 0, 0),
(142, 86, 0, 0, 0),
(143, 87, 0, 0, 0),
(144, 88, 0, 0, 0),
(145, 89, 0, 0, 0),
(146, 90, 0, 0, 0),
(147, 91, 0, 0, 0),
(148, 92, 0, 0, 0),
(149, 93, 0, 0, 0),
(150, 94, 0, 0, 0),
(151, 95, 0, 0, 0),
(152, 96, 0, 0, 0),
(153, 97, 0, 0, 0),
(154, 98, 0, 0, 0),
(155, 99, 0, 0, 0),
(156, 100, 0, 0, 0),
(157, 101, 0, 0, 0),
(158, 102, 0, 0, 0),
(159, 103, 0, 0, 0),
(160, 104, 0, 0, 0),
(161, 105, 0, 0, 0),
(162, 106, 0, 0, 0),
(163, 107, 0, 0, 0),
(164, 108, 0, 0, 0),
(165, 109, 0, 0, 0),
(166, 110, 0, 0, 0),
(167, 111, 0, 0, 0),
(168, 112, 0, 0, 0),
(169, 113, 0, 0, 0),
(170, 114, 0, 0, 0),
(171, 115, 0, 0, 0),
(172, 116, 0, 0, 0),
(173, 117, 0, 0, 0),
(174, 118, 0, 0, 0),
(175, 119, 0, 0, 0),
(176, 120, 0, 0, 0),
(177, 121, 0, 0, 0),
(178, 122, 0, 0, 0),
(179, 123, 0, 0, 0),
(180, 124, 0, 0, 0),
(181, 125, 0, 0, 0),
(182, 126, 0, 0, 0),
(183, 127, 0, 0, 0),
(184, 128, 0, 0, 0),
(185, 129, 0, 0, 0),
(186, 130, 0, 0, 0),
(187, 131, 0, 0, 0),
(188, 132, 0, 0, 0),
(189, 133, 0, 0, 0),
(190, 134, 0, 0, 0),
(191, 135, 0, 0, 0),
(192, 136, 0, 0, 0),
(193, 137, 0, 0, 0),
(194, 138, 0, 0, 0),
(195, 139, 0, 0, 0),
(196, 140, 0, 0, 0),
(197, 141, 0, 0, 0),
(198, 142, 0, 0, 0),
(199, 143, 0, 0, 0),
(200, 144, 0, 0, 0),
(201, 145, 0, 0, 0),
(202, 146, 0, 0, 0),
(203, 147, 0, 0, 0),
(204, 148, 0, 0, 0),
(205, 149, 0, 0, 0),
(206, 150, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `accion` varchar(200) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pendientes`
--

CREATE TABLE `pendientes` (
  `id` int(11) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(20) DEFAULT 'Pendiente',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `fecha_limite` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pendientes`
--

INSERT INTO `pendientes` (`id`, `titulo`, `descripcion`, `estado`, `fecha_creacion`, `fecha_limite`) VALUES
(1, 'asdqw', 'dwqd', 'Pendiente', '2025-07-07 22:55:24', '2025-07-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `icono` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`id`, `nombre`, `slug`, `icono`) VALUES
(1, 'Dashboard', 'dashboard', 'fa-tachometer-alt'),
(2, 'Inventario', 'inventario', 'fa-boxes'),
(3, 'Clientes', 'clientes', 'fa-users'),
(4, 'Proveedores', 'proveedores', 'fa-truck'),
(5, 'Usuarios', 'usuarios', 'fa-user-cog'),
(6, 'Cotización', 'cotizacion', 'fa-file-invoice-dollar'),
(7, 'Ventas', 'ventas', 'fa-dollar-sign'),
(8, 'Servicios', 'servicios', 'fa-tools'),
(9, 'Reportes', 'reportes', 'fa-chart-bar'),
(10, 'Roles y permisos', 'roles', 'fa-key'),
(41, 'Pendientes', 'pendientes', 'fa-clock');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `id` int(11) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `rol_id` int(11) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `documento`, `nombres`, `apellidos`, `correo`, `rol_id`, `activo`) VALUES
(1, '10000001', 'Carlos', 'García', 'carlos.garcia1@mail.com', 1, 1),
(2, '10000002', 'María', 'López', 'maria.lopez2@mail.com', 2, 1),
(3, '10000003', 'Juan', 'Pérez', 'juan.perez3@mail.com', 1, 1),
(4, '10000004', 'Lucía', 'Ramírez', 'lucia.ramirez4@mail.com', 2, 1),
(5, '10000005', 'Pedro', 'Fernández', 'pedro.fernandez5@mail.com', 1, 1),
(6, '10000006', 'Ana', 'Martínez', 'ana.martinez6@mail.com', 2, 1),
(7, '10000007', 'Diego', 'Rojas', 'diego.rojas7@mail.com', 1, 1),
(8, '10000008', 'Laura', 'Sánchez', 'laura.sanchez8@mail.com', 2, 1),
(9, '10000009', 'José', 'Torres', 'jose.torres9@mail.com', 1, 1),
(10, '10000010', 'Carmen', 'Ruiz', 'carmen.ruiz10@mail.com', 2, 1),
(11, '10000011', 'Luis', 'Castro', 'luis.castro11@mail.com', 1, 1),
(12, '10000012', 'Patricia', 'Delgado', 'patricia.delgado12@mail.com', 2, 1),
(13, '10000013', 'Andrés', 'Flores', 'andres.flores13@mail.com', 1, 1),
(14, '10000014', 'Daniela', 'Vega', 'daniela.vega14@mail.com', 2, 1),
(15, '10000015', 'Javier', 'Morales', 'javier.morales15@mail.com', 1, 1),
(16, '10000016', 'Sofía', 'Navarro', 'sofia.navarro16@mail.com', 2, 1),
(17, '10000017', 'Miguel', 'Reyes', 'miguel.reyes17@mail.com', 1, 1),
(18, '10000018', 'Isabel', 'Cabrera', 'isabel.cabrera18@mail.com', 2, 1),
(19, '10000019', 'Oscar', 'Mendoza', 'oscar.mendoza19@mail.com', 1, 1),
(20, '10000020', 'Elena', 'Silva', 'elena.silva20@mail.com', 2, 1),
(21, '10000021', 'Ricardo', 'Campos', 'ricardo.campos21@mail.com', 1, 1),
(22, '10000022', 'Valeria', 'Paredes', 'valeria.paredes22@mail.com', 2, 1),
(23, '10000023', 'Fernando', 'Acosta', 'fernando.acosta23@mail.com', 1, 1),
(24, '10000024', 'Gabriela', 'Salas', 'gabriela.salas24@mail.com', 2, 1),
(25, '10000025', 'Martín', 'León', 'martin.leon25@mail.com', 1, 1),
(26, '10000026', 'Renata', 'Peña', 'renata.pena26@mail.com', 2, 1),
(27, '10000027', 'Víctor', 'Soto', 'victor.soto27@mail.com', 1, 1),
(28, '10000028', 'Mónica', 'Ríos', 'monica.rios28@mail.com', 2, 1),
(29, '10000029', 'Alberto', 'Mejía', 'alberto.mejia29@mail.com', 1, 1),
(30, '10000030', 'Rocío', 'Vargas', 'rocio.vargas30@mail.com', 2, 1),
(31, '10000031', 'Cristian', 'Ibarra', 'cristian.ibarra31@mail.com', 1, 1),
(32, '10000032', 'Noelia', 'Mora', 'noelia.mora32@mail.com', 2, 1),
(33, '10000033', 'Manuel', 'Carranza', 'manuel.carranza33@mail.com', 1, 1),
(34, '10000034', 'Clara', 'Quispe', 'clara.quispe34@mail.com', 2, 1),
(35, '10000035', 'Raúl', 'Núñez', 'raul.nunez35@mail.com', 1, 1),
(36, '10000036', 'Daniela', 'Guzmán', 'daniela.guzman36@mail.com', 2, 1),
(37, '10000037', 'Ángel', 'Ortega', 'angel.ortega37@mail.com', 1, 1),
(38, '10000038', 'Tatiana', 'Montoya', 'tatiana.montoya38@mail.com', 2, 1),
(39, '10000039', 'Fabián', 'Rentería', 'fabian.renteria39@mail.com', 1, 1),
(40, '10000040', 'Camila', 'Espinoza', 'camila.espinoza40@mail.com', 2, 1),
(41, '10000041', 'Sebastián', 'Valle', 'sebastian.valle41@mail.com', 1, 1),
(42, '10000042', 'Luna', 'Gamarra', 'luna.gamarra42@mail.com', 2, 1),
(43, '10000043', 'Iván', 'Benites', 'ivan.benites43@mail.com', 1, 1),
(44, '10000044', 'Carla', 'Ramos', 'carla.ramos44@mail.com', 2, 1),
(45, '10000045', 'Esteban', 'Solís', 'esteban.solis45@mail.com', 1, 1),
(46, '10000046', 'Lorena', 'Becerra', 'lorena.becerra46@mail.com', 2, 1),
(47, '10000047', 'Tomás', 'Rosales', 'tomas.rosales47@mail.com', 1, 1),
(48, '10000048', 'Yesenia', 'Rivadeneira', 'yesenia.rivadeneira48@mail.com', 2, 1),
(49, '10000049', 'Marco', 'Zambrano', 'marco.zambrano49@mail.com', 1, 1),
(50, '10000050', 'Paola', 'Delgado', 'paola.delgado50@mail.com', 2, 1),
(51, '00000000', 'Amet Marcelo', 'Quispe Espichan', 'quispeamet2@gmail.com', 1, 1),
(52, '00000000', 'Amet Marcelo', 'Quispe Espichan', 'quispeamet2@gmail.com', 1, 1),
(53, '00000000', 'Josue ', 'Sandoval Herrera', 'josuesandovalherrera26@gmail.com', 1, 1),
(54, '00000000', 'José Carlos', 'Hidalgo Romero', 'U20233784@utp.edu.pe', 1, 1),
(55, '00000000', 'Michael Olazabal', 'Yacila', 'U23236416@UTP.EDU.PE', 1, 1),
(56, '00000000', 'Patrick Leonel', 'Heighes Romero', 'partfirebase12@gmail.com', 1, 1),
(57, '00000001', 'Amet', 'Quispe', 'quispeamet2@gmail.com', 3, 1),
(58, '00000000', 'Amet Marcelo', 'Quispe Espichan', 'quispeamet5@gmail.com', 1, 1),
(59, '10000059', 'Roberto', 'Castillo', 'roberto.castillo59@mail.com', 1, 1),
(60, '10000060', 'Diana', 'Herrera', 'diana.herrera60@mail.com', 2, 1),
(61, '10000061', 'Mario', 'Guerra', 'mario.guerra61@mail.com', 1, 1),
(62, '10000062', 'Andrea', 'Paz', 'andrea.paz62@mail.com', 2, 1),
(63, '10000063', 'Pablo', 'Vidal', 'pablo.vidal63@mail.com', 1, 1),
(64, '10000064', 'Verónica', 'Montes', 'veronica.montes64@mail.com', 2, 1),
(65, '10000065', 'Diego', 'Aguilar', 'diego.aguilar65@mail.com', 1, 1),
(66, '10000066', 'Carolina', 'Benítez', 'carolina.benitez66@mail.com', 2, 1),
(67, '10000067', 'Gustavo', 'Cáceres', 'gustavo.caceres67@mail.com', 1, 1),
(68, '10000068', 'Silvia', 'Díaz', 'silvia.diaz68@mail.com', 2, 1),
(69, '10000069', 'Ignacio', 'Estrada', 'ignacio.estrada69@mail.com', 1, 1),
(70, '10000070', 'Julia', 'Franco', 'julia.franco70@mail.com', 2, 1),
(71, '10000071', 'Alejandro', 'Gómez', 'alejandro.gomez71@mail.com', 1, 1),
(72, '10000072', 'Beatriz', 'Hernández', 'beatriz.hernandez72@mail.com', 2, 1),
(73, '10000073', 'Benjamín', 'Jiménez', 'benjamin.jimenez73@mail.com', 1, 1),
(74, '10000074', 'Sofía', 'Lara', 'sofia.lara74@mail.com', 2, 1),
(75, '10000075', 'Gabriel', 'Molina', 'gabriel.molina75@mail.com', 1, 1),
(76, '10000076', 'Natalia', 'Nieto', 'natalia.nieto76@mail.com', 2, 1),
(77, '10000077', 'Jorge', 'Ortiz', 'jorge.ortiz77@mail.com', 1, 1),
(78, '10000078', 'Laura', 'Pérez', 'laura.perez78@mail.com', 2, 1),
(79, '10000079', 'Sergio', 'Quinteros', 'sergio.quinteros79@mail.com', 1, 1),
(80, '10000080', 'Adriana', 'Reyes', 'adriana.reyes80@mail.com', 2, 1),
(81, '10000081', 'Gonzalo', 'Salazar', 'gonzalo.salazar81@mail.com', 1, 1),
(82, '10000082', 'Daniela', 'Tapia', 'daniela.tapia82@mail.com', 2, 1),
(83, '10000083', 'Emilio', 'Urbina', 'emilio.urbina83@mail.com', 1, 1),
(84, '10000084', 'Florencia', 'Valenzuela', 'florencia.valenzuela84@mail.com', 2, 1),
(85, '10000085', 'Hugo', 'Wong', 'hugo.wong85@mail.com', 1, 1),
(86, '10000086', 'Isidora', 'Yáñez', 'isidora.yanez86@mail.com', 2, 1),
(87, '10000087', 'Joaquín', 'Zúñiga', 'joaquin.zuniga87@mail.com', 1, 1),
(88, '10000088', 'Karen', 'Álvarez', 'karen.alvarez88@mail.com', 2, 1),
(89, '10000089', 'Leo', 'Bravo', 'leo.bravo89@mail.com', 1, 1),
(90, '10000090', 'Paula', 'Cortés', 'paula.cortes90@mail.com', 2, 1),
(91, '10000091', 'Romina', 'Domínguez', 'romina.dominguez91@mail.com', 1, 1),
(92, '10000092', 'Santiago', 'Espinoza', 'santiago.espinoza92@mail.com', 2, 1),
(93, '10000093', 'Victoria', 'Fuentes', 'victoria.fuentes93@mail.com', 1, 1),
(94, '10000094', 'Maximiliano', 'González', 'maximiliano.gonzalez94@mail.com', 2, 1),
(95, '10000095', 'Constanza', 'Herrera', 'constanza.herrera95@mail.com', 1, 1),
(96, '10000096', 'Felipe', 'Jiménez', 'felipe.jimenez96@mail.com', 2, 1),
(97, '10000097', 'Fernanda', 'King', 'fernanda.king97@mail.com', 1, 1),
(98, '10000098', 'Cristóbal', 'Lagos', 'cristobal.lagos98@mail.com', 2, 1),
(99, '10000099', 'Sofía', 'Muñoz', 'sofia.munoz99@mail.com', 1, 1),
(100, '10000100', 'Martín', 'Novak', 'martin.novak100@mail.com', 2, 1),
(101, '10000101', 'Valentina', 'Olivares', 'valentina.olivares101@mail.com', 1, 1),
(102, '10000102', 'Francisco', 'Pizarro', 'francisco.pizarro102@mail.com', 2, 1),
(103, '10000103', 'Catalina', 'Quezada', 'catalina.quezada103@mail.com', 1, 1),
(104, '10000104', 'Diego', 'Ramírez', 'diego.ramirez104@mail.com', 2, 1),
(105, '10000105', 'Isidora', 'Sepúlveda', 'isidora.sepulveda105@mail.com', 1, 1),
(106, '10000106', 'Nicolás', 'Toledo', 'nicolas.toledo106@mail.com', 2, 1),
(107, '10000107', 'Josefa', 'Ulloa', 'josefa.ulloa107@mail.com', 1, 1),
(108, '10000108', 'Felipe', 'Vargas', 'felipe.vargas108@mail.com', 2, 1),
(109, '10000109', 'Maite', 'Walker', 'maite.walker109@mail.com', 1, 1),
(110, '10000110', 'Andrés', 'Ximénez', 'andres.ximenez110@mail.com', 2, 1),
(111, '10000111', 'Javiera', 'Yáñez', 'javiera.yanez111@mail.com', 1, 1),
(112, '10000112', 'Tomás', 'Zamora', 'tomas.zamora112@mail.com', 2, 1),
(113, '10000113', 'Antonia', 'Abarca', 'antonia.abarca113@mail.com', 1, 1),
(114, '10000114', 'Matías', 'Becerra', 'matias.becerra114@mail.com', 2, 1),
(115, '10000115', 'Florencia', 'Contreras', 'florencia.contreras115@mail.com', 1, 1),
(116, '10000116', 'Rodrigo', 'Díaz', 'rodrigo.diaz116@mail.com', 2, 1),
(117, '10000117', 'Camila', 'Escobar', 'camila.escobar117@mail.com', 1, 1),
(118, '10000118', 'Sebastián', 'Fuentes', 'sebastian.fuentes118@mail.com', 2, 1),
(119, '10000119', 'Valentina', 'Gajardo', 'valentina.gajardo119@mail.com', 1, 1),
(120, '10000120', 'Benjamín', 'Henríquez', 'benjamin.henriquez120@mail.com', 2, 1),
(121, '10000121', 'Emilia', 'Inostroza', 'emilia.inostroza121@mail.com', 1, 1),
(122, '10000122', 'Gabriel', 'Jara', 'gabriel.jara122@mail.com', 2, 1),
(123, '10000123', 'Amanda', 'López', 'amanda.lopez123@mail.com', 1, 1),
(124, '10000124', 'Cristián', 'Maldonado', 'cristian.maldonado124@mail.com', 2, 1),
(125, '10000125', 'Sofía', 'Núñez', 'sofia.nunez125@mail.com', 1, 1),
(126, '10000126', 'Ignacio', 'Orellana', 'ignacio.orellana126@mail.com', 2, 1),
(127, '10000127', 'Paula', 'Pérez', 'paula.perez127@mail.com', 1, 1),
(128, '10000128', 'Ricardo', 'Quezada', 'ricardo.quezada128@mail.com', 2, 1),
(129, '10000129', 'Josefina', 'Rojas', 'josefina.rojas129@mail.com', 1, 1),
(130, '10000130', 'Manuel', 'Salinas', 'manuel.salinas130@mail.com', 2, 1),
(131, '10000131', 'Daniela', 'Tapia', 'daniela.tapia131@mail.com', 1, 1),
(132, '10000132', 'Francisco', 'Urrutia', 'francisco.urrutia132@mail.com', 2, 1),
(133, '10000133', 'Florencia', 'Valdés', 'florencia.valdes133@mail.com', 1, 1),
(134, '10000134', 'Diego', 'Vera', 'diego.vera134@mail.com', 2, 1),
(135, '10000135', 'Martina', 'Weber', 'martina.weber135@mail.com', 1, 1),
(136, '10000136', 'Benjamín', 'Yáñez', 'benjamin.yanez136@mail.com', 2, 1),
(137, '10000137', 'Antonia', 'Zúñiga', 'antonia.zuniga137@mail.com', 1, 1),
(138, '10000138', 'Sebastián', 'Arriagada', 'sebastian.arriagada138@mail.com', 2, 1),
(139, '10000139', 'Isidora', 'Burgos', 'isidora.burgos139@mail.com', 1, 1),
(140, '10000140', 'Nicolás', 'Carrasco', 'nicolas.carrasco140@mail.com', 2, 1),
(141, '10000141', 'Josefa', 'Donoso', 'josefa.donoso141@mail.com', 1, 1),
(142, '10000142', 'Felipe', 'Echeverría', 'felipe.echeverria142@mail.com', 2, 1),
(143, '10000143', 'Valeria', 'Fuentes', 'valeria.fuentes143@mail.com', 1, 1),
(144, '10000144', 'Gonzalo', 'Gálvez', 'gonzalo.galvez144@mail.com', 2, 1),
(145, '10000145', 'Camila', 'Henríquez', 'camila.henriquez145@mail.com', 1, 1),
(146, '10000146', 'Vicente', 'Jara', 'vicente.jara146@mail.com', 2, 1),
(147, '10000147', 'Catalina', 'Lagos', 'catalina.lagos147@mail.com', 1, 1),
(148, '10000148', 'Diego', 'Miranda', 'diego.miranda148@mail.com', 2, 1),
(149, '10000149', 'María', 'Navarro', 'maria.navarro149@mail.com', 1, 1),
(150, '10000150', 'Cristian', 'Olivares', 'cristian.olivares150@mail.com', 2, 1),
(151, '00000000', 'Amet Marcelo', 'Quispe Espichan', 'quispeamet4@gmail.com', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  `marca` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `stock_minimo` int(11) DEFAULT 0,
  `costo` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `codigo`, `categoria_id`, `marca`, `nombre`, `precio`, `imagen`, `activo`, `stock_minimo`, `costo`) VALUES
(1, 'P001', 1, 'Bosch', 'Filtro de aceite', 25.50, NULL, 1, 0, 8.79),
(2, 'P002', 2, '3M', 'Ambientador de auto', 8.90, NULL, 1, 0, 8.29),
(3, 'P003', 1, 'NGK', 'Bujía estándar', 12.00, NULL, 1, 0, 11.25),
(4, 'P004', 2, 'Pioneer', 'Soporte de celular', 15.00, NULL, 1, 0, 2.50),
(5, 'P005', 1, 'Mobil', 'Aceite sintético 5W30', 39.99, NULL, 1, 0, 0.00),
(6, 'P006', 2, 'Armor All', 'Paño de microfibra', 5.50, NULL, 1, 0, 0.00),
(7, 'P007', 1, 'ACDelco', 'Filtro de aire', 18.75, NULL, 1, 0, 0.00),
(8, 'P008', 2, 'Philips', 'Bombilla LED H4', 22.10, NULL, 1, 0, 3.42),
(9, 'P009', 1, 'Denso', 'Sensor de oxígeno', 45.00, NULL, 1, 0, 0.00),
(10, 'P010', 2, 'Sony', 'Cargador USB para auto', 10.99, NULL, 1, 0, 75.00),
(11, 'P011', 1, 'Bosch', 'Pastilla de freno delantera', 30.50, NULL, 1, 0, 45.00),
(12, 'P012', 2, 'Turtle Wax', 'Cera líquida', 12.25, NULL, 1, 0, 0.00),
(13, 'P013', 1, 'Champion', 'Filtro de combustible', 20.00, NULL, 1, 0, 0.00),
(14, 'P014', 2, 'Kenwood', 'Parlante 6x9', 50.00, NULL, 1, 0, 250.00),
(15, 'P015', 1, 'Castrol', 'Aceite 10W40', 28.00, NULL, 1, 0, 9.00),
(16, 'P016', 2, 'Meguiar\'s', 'Limpiavidrios', 6.75, NULL, 1, 0, 0.00),
(17, 'P017', 1, 'Delphi', 'Inyector de combustible', 85.00, NULL, 1, 0, 0.00),
(18, 'P018', 2, 'JBL', 'Altavoz bluetooth', 60.00, NULL, 1, 0, 0.00),
(19, 'P019', 1, 'Valeo', 'Disco de embrague', 95.00, NULL, 1, 0, 29.00),
(20, 'P020', 2, 'Goodyear', 'Kit de seguridad', 35.00, NULL, 1, 0, 0.00),
(21, 'P021', 1, 'Motorcraft', 'Bobina de encendido', 70.00, NULL, 1, 0, 0.00),
(22, 'P022', 2, 'Panasonic', 'Cable auxiliar', 4.50, NULL, 1, 0, 0.00),
(23, 'P023', 1, 'Autolite', 'Sensor MAP', 40.00, NULL, 1, 0, 0.00),
(24, 'P024', 2, 'Belkin', 'Cargador rápido', 14.90, NULL, 1, 0, 30.00),
(25, 'P025', 1, 'Bosch', 'Rotor de freno', 55.00, NULL, 1, 0, 0.00),
(26, 'P026', 2, 'Kicker', 'Subwoofer para auto', 120.00, NULL, 1, 0, 0.00),
(27, 'P027', 1, 'NGK', 'Cable de bujía', 18.00, NULL, 1, 0, 0.00),
(28, 'P028', 2, 'Baseus', 'Soporte magnético', 7.90, NULL, 1, 0, 0.00),
(29, 'P029', 1, 'ACDelco', 'Termostato', 26.50, NULL, 1, 0, 0.00),
(30, 'P030', 2, 'Anker', 'Cargador de encendedor', 11.99, NULL, 1, 0, 15.00),
(31, 'P031', 1, 'Denso', 'Relay automotriz', 9.90, NULL, 1, 0, 0.00),
(32, 'P032', 2, 'Sony', 'Adaptador bluetooth', 17.50, NULL, 1, 0, 0.00),
(33, 'P033', 1, 'Valeo', 'Sensor ABS', 48.00, NULL, 1, 0, 0.00),
(34, 'P034', 2, 'Targus', 'Soporte con ventilador', 22.00, NULL, 1, 0, 0.00),
(35, 'P035', 1, 'Delphi', 'Válvula IAC', 38.90, NULL, 1, 0, 0.00),
(36, 'P036', 2, 'Xiaomi', 'Luz LED interior', 9.50, NULL, 1, 0, 0.00),
(37, 'P037', 1, 'Bosch', 'Bomba de freno', 65.00, NULL, 1, 0, 0.00),
(38, 'P038', 2, 'Sony', 'Manos libres', 25.00, NULL, 1, 0, 0.00),
(39, 'P039', 1, 'Castrol', 'Grasa multiuso', 6.80, NULL, 1, 0, 0.00),
(40, 'P040', 2, 'Turtle Wax', 'Limpiador de llantas', 7.20, NULL, 1, 0, 0.00),
(41, 'P041', 1, 'Mobil', 'Líquido de frenos DOT4', 9.60, NULL, 1, 0, 0.00),
(42, 'P042', 2, 'Armor All', 'Espuma limpiadora', 5.30, NULL, 1, 0, 0.00),
(43, 'P043', 1, 'NGK', 'Sensor de temperatura', 21.00, NULL, 1, 0, 0.00),
(44, 'P044', 2, '3M', 'Esponja de pulido', 4.20, NULL, 1, 0, 0.00),
(45, 'P045', 1, 'Champion', 'Cable de batería', 8.90, NULL, 1, 0, 0.00),
(46, 'P046', 2, 'Meguiar\'s', 'Cera rápida', 10.90, NULL, 0, 0, 0.00),
(47, 'P047', 1, 'Valeo', 'Interruptor de luces', 17.40, NULL, 1, 0, 0.00),
(48, 'P048', 2, 'Pioneer', 'Control remoto', 15.00, NULL, 1, 0, 0.00),
(49, 'P049', 1, 'Autolite', 'Válvula EGR', 49.00, NULL, 1, 0, 0.00),
(50, 'P050', 4, '11111', 'Organizador de cables', 20.00, NULL, 0, 0, 0.00),
(54, 'P051', 2, 'Sony', 'Espejo retrovisor', 99.00, NULL, 1, 0, 0.00),
(55, 'P052', 3, 'Sony', 'Funda para timón', 80.00, NULL, 0, 0, 0.00),
(56, 'P053', 3, 'Turtle Wax', 'Lubricante de litro', 45.00, NULL, 0, 0, 0.00),
(57, 'P054', 1, 'Turtle Wax', 'Llantas', 350.00, NULL, 0, 0, 0.00),
(59, 'P055', 2, 'Turtle Wax', 'Funda para timón', 150.00, NULL, 0, 5, 135.00),
(60, 'P056', 2, 'Turtle Wax', 'alfombra para auto', 139.00, NULL, 1, 5, 100.00),
(61, 'P057', 3, 'Liqui Moly', 'Aditivo para motor', 45.00, NULL, 1, 10, 35.00),
(62, 'P058', 5, 'Michelin', 'Llanta Aro 15', 350.00, NULL, 1, 4, 280.00),
(63, 'P059', 4, 'Stanley', 'Juego de llaves Allen', 80.00, NULL, 1, 5, 60.00),
(64, 'P060', 1, 'Gates', 'Correa de distribución', 120.00, NULL, 1, 8, 95.00),
(65, 'P057', 3, 'Liqui Moly', 'Aditivo para motor', 45.00, NULL, 1, 10, 35.00),
(66, 'P058', 5, 'Michelin', 'Llanta Aro 15', 350.00, NULL, 1, 4, 280.00),
(67, 'P059', 4, 'Stanley', 'Juego de llaves Allen', 80.00, NULL, 1, 5, 60.00),
(68, 'P060', 1, 'Gates', 'Correa de distribución', 120.00, NULL, 1, 8, 95.00),
(69, 'P061', 2, 'Sonax', 'Shampoo para auto con cera', 35.00, NULL, 1, 15, 25.00),
(70, 'P070', 1, 'Michelin', 'Neumático Deportivo', 180.00, NULL, 1, 5, 140.00),
(71, 'P071', 2, 'Sony', 'Radio Automotriz MP3', 75.00, NULL, 1, 2, 50.00),
(72, 'P072', 3, 'Bosch', 'Batería de Arranque', 90.00, NULL, 1, 3, 70.00),
(73, 'P073', 4, 'Stanley', 'Set de Destornilladores', 30.00, NULL, 1, 5, 20.00),
(74, 'P074', 5, '3M', 'Cinta Adhesiva Industrial', 15.00, NULL, 1, 10, 8.00),
(75, 'P075', 1, 'Mobil', 'Aceite para Caja Automática', 40.00, NULL, 1, 4, 30.00),
(76, 'P076', 2, 'Pioneer', 'Cámara de Reversa', 60.00, NULL, 1, 3, 45.00),
(77, 'P077', 3, 'ACDelco', 'Amortiguador Trasero', 85.00, NULL, 1, 2, 65.00),
(78, 'P078', 4, 'Black+Decker', 'Taladro Inalámbrico', 110.00, NULL, 1, 1, 85.00),
(79, 'P079', 5, 'Karcher', 'Hidrolavadora Portátil', 150.00, NULL, 1, 1, 110.00),
(80, 'P080', 1, 'Denso', 'Bomba de Agua', 70.00, NULL, 1, 2, 55.00),
(81, 'P081', 2, 'JBL', 'Amplificador de Audio', 130.00, NULL, 1, 1, 100.00),
(82, 'P082', 3, 'Monroe', 'Kit de Embrague Completo', 200.00, NULL, 1, 1, 160.00),
(83, 'P083', 4, 'Truper', 'Llave Ajustable', 18.00, NULL, 1, 8, 12.00),
(84, 'P084', 5, 'CRC', 'Limpiador de Contactos', 12.00, NULL, 1, 10, 7.00),
(85, 'P085', 1, 'Castrol', 'Anticongelante Concentrado', 25.00, NULL, 1, 5, 18.00),
(86, 'P086', 2, 'Kenwood', 'Subwoofer Activo', 160.00, NULL, 1, 1, 120.00),
(87, 'P087', 3, 'KYB', 'Horquilla de Suspensión', 95.00, NULL, 1, 2, 75.00),
(88, 'P088', 4, 'Prestone', 'Líquido de Frenos Sintético', 14.00, NULL, 1, 7, 9.00),
(89, 'P089', 5, 'WD-40', 'Aceite Multiusos', 8.50, NULL, 1, 15, 5.00),
(90, 'P090', 1, 'NGK', 'Sensor MAF', 65.00, NULL, 1, 2, 50.00),
(91, 'P091', 2, 'Alpine', 'Reproductor Multimedia', 180.00, NULL, 1, 1, 140.00),
(92, 'P092', 3, 'FAG', 'Rodamiento de Rueda', 42.00, NULL, 1, 5, 30.00),
(93, 'P093', 4, 'Dremel', 'Amoladora de Precisión', 55.00, NULL, 1, 3, 40.00),
(94, 'P094', 5, 'Permatex', 'Sellador de Roscas', 9.00, NULL, 1, 10, 6.00),
(95, 'P095', 1, 'Bosch', 'Válvula PCV', 28.00, NULL, 1, 5, 20.00),
(96, 'P096', 2, 'Philips', 'Focos LED para Interior', 10.00, NULL, 1, 15, 6.00),
(97, 'P097', 3, 'Gates', 'Manguera de Radiador', 35.00, NULL, 1, 4, 25.00),
(98, 'P098', 4, 'Urrea', 'Juego de Dados Métricos', 70.00, NULL, 1, 3, 55.00),
(99, 'P099', 5, 'Gunk', 'Desengrasante para Motor', 16.00, NULL, 1, 8, 10.00),
(100, 'P100', 1, 'Goodyear', 'Manguera de Dirección', 48.00, NULL, 1, 3, 35.00),
(101, 'P101', 2, 'Garmin', 'Navegador GPS', 100.00, NULL, 1, 2, 75.00),
(102, 'P102', 3, 'Lucas', 'Bomba de Combustible', 115.00, NULL, 1, 1, 90.00),
(103, 'P103', 4, 'Craftsman', 'Caja de Herramientas', 90.00, NULL, 1, 2, 65.00),
(104, 'P104', 5, 'STP', 'Aditivo Limpiador de Inyectores', 13.00, NULL, 1, 10, 8.00),
(105, 'P105', 1, 'Standard Motor', 'Sensor de Velocidad', 32.00, NULL, 1, 5, 22.00),
(106, 'P106', 2, 'Pioneer', 'Pantalla Táctil', 250.00, NULL, 1, 1, 190.00),
(107, 'P107', 3, 'Brembo', 'Disco de Freno Trasero', 70.00, NULL, 1, 4, 55.00),
(108, 'P108', 4, 'Channellock', 'Pinza de Punta Larga', 20.00, NULL, 1, 8, 14.00),
(109, 'P109', 5, 'Meguiar\'s', 'Renovador de Plásticos', 11.00, NULL, 1, 10, 7.00),
(110, 'P110', 1, 'Denso', 'Bomba de Aceite', 95.00, NULL, 1, 2, 70.00),
(111, 'P111', 2, 'GoPro', 'Cámara de Acción para Auto', 280.00, NULL, 1, 1, 220.00),
(112, 'P112', 3, 'TRW', 'Cilindro Maestro de Freno', 60.00, NULL, 1, 3, 45.00),
(113, 'P113', 4, 'Klein Tools', 'Multímetro Digital', 45.00, NULL, 1, 3, 30.00),
(114, 'P114', 5, 'Armor All', 'Cera Protectora para Tablero', 7.50, NULL, 1, 12, 4.50),
(115, 'P115', 1, 'Valeo', 'Kit de Embrague', 150.00, NULL, 1, 2, 115.00),
(116, 'P116', 2, 'JVC', 'Autoestéreo con Bluetooth', 88.00, NULL, 1, 2, 65.00),
(117, 'P117', 3, 'Moog', 'Terminal de Dirección', 38.00, NULL, 1, 5, 28.00),
(118, 'P118', 4, 'Milwaukee', 'Llave de Impacto Eléctrica', 170.00, NULL, 1, 1, 130.00),
(119, 'P119', 5, 'Sonax', 'Champú para Coche Concentrado', 19.00, NULL, 1, 7, 12.00),
(120, 'P120', 1, 'Dorman', 'Soporte de Motor', 52.00, NULL, 1, 4, 38.00),
(121, 'P121', 2, 'Pyle', 'Altavoz de Techo para Auto', 40.00, NULL, 1, 5, 28.00),
(122, 'P122', 3, 'Febi Bilstein', 'Buje de Suspensión', 22.00, NULL, 1, 10, 15.00),
(123, 'P123', 4, 'IRWIN', 'Sierra Caladora', 68.00, NULL, 1, 2, 50.00),
(124, 'P124', 5, 'Turtle Wax', 'Restaurador de Faros', 26.00, NULL, 1, 6, 18.00),
(125, 'P125', 1, 'ZF', 'Kit de Transmisión', 300.00, NULL, 1, 1, 240.00),
(126, 'P126', 2, 'Rockford Fosgate', 'Capacitador de Audio', 90.00, NULL, 1, 2, 70.00),
(127, 'P127', 3, 'ContiTech', 'Correa de Accesorios', 28.00, NULL, 1, 7, 20.00),
(128, 'P128', 4, 'Stanley FatMax', 'Nivel de Burbuja', 35.00, NULL, 1, 5, 25.00),
(129, 'P129', 5, 'Chemical Guys', 'Sellador Cerámico', 45.00, NULL, 1, 3, 30.00),
(130, 'P130', 1, 'Hella', 'Faro Antiniebla', 58.00, NULL, 1, 4, 42.00),
(131, 'P131', 2, 'Pioneer', 'Cable RCA de Alta Calidad', 9.00, NULL, 1, 15, 5.00),
(132, 'P132', 3, 'Gates', 'Junta de Culata', 80.00, NULL, 1, 2, 60.00),
(133, 'P133', 4, 'DeWalt', 'Atornillador de Impacto', 140.00, NULL, 1, 1, 105.00),
(134, 'P134', 5, 'Mothers', 'Limpiador de Tapicería', 17.00, NULL, 1, 8, 11.00),
(135, 'P135', 1, 'Delphi', 'Bomba de Dirección Asistida', 130.00, NULL, 1, 1, 100.00),
(136, 'P136', 2, 'Kicker', 'Altavoz Coaxial', 70.00, NULL, 1, 3, 55.00),
(137, 'P137', 3, 'SKF', 'Kit de Distribución', 160.00, NULL, 1, 1, 120.00),
(138, 'P138', 4, 'GearWrench', 'Set de Llaves Combinadas', 65.00, NULL, 1, 4, 48.00),
(139, 'P139', 5, 'Meguiar\'s', 'Acondicionador de Neumáticos', 12.50, NULL, 1, 10, 8.00),
(140, 'P140', 1, 'ACDelco', 'Bobina de Encendido', 75.00, NULL, 1, 3, 55.00),
(141, 'P141', 2, 'Alpine', 'Procesador de Sonido Digital', 350.00, NULL, 1, 1, 280.00),
(142, 'P142', 3, 'Bosch', 'Sensor de Cigüeñal', 50.00, NULL, 1, 5, 38.00),
(143, 'P143', 4, 'Makita', 'Sierra Circular', 190.00, NULL, 1, 1, 150.00),
(144, 'P144', 5, 'Valvoline', 'Limpiador de Motor', 10.00, NULL, 1, 12, 6.00),
(145, 'P145', 1, 'Denso', 'Bujía de Iridium', 28.00, NULL, 1, 8, 20.00),
(146, 'P146', 2, 'Clarion', 'Receptor de CD', 110.00, NULL, 1, 2, 85.00),
(147, 'P147', 3, 'Continental', 'Manguera de Vacío', 14.00, NULL, 1, 10, 9.00),
(148, 'P148', 4, 'Crescent', 'Alicates de Corte Diagonal', 25.00, NULL, 1, 7, 18.00),
(149, 'P149', 5, 'Liqui Moly', 'Limpiador de Frenos', 9.00, NULL, 1, 15, 6.00),
(150, 'P150', 1, 'Motorcraft', 'Filtro de Cabina', 20.00, NULL, 1, 10, 14.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_proveedores`
--

CREATE TABLE `productos_proveedores` (
  `id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `proveedor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_proveedores`
--

INSERT INTO `productos_proveedores` (`id`, `producto_id`, `proveedor_id`) VALUES
(1, 1, 1),
(2, 1, 4),
(3, 5, 5),
(4, 11, 4),
(5, 15, 5),
(6, 61, 5),
(7, 62, 4),
(8, 63, 1),
(9, 64, 4),
(10, 1, 1),
(11, 2, 2),
(12, 3, 3),
(13, 4, 4),
(14, 5, 5),
(15, 6, 6),
(16, 7, 7),
(17, 8, 1),
(18, 9, 2),
(19, 10, 3),
(20, 11, 4),
(21, 12, 5),
(22, 13, 6),
(23, 14, 7),
(24, 15, 1),
(25, 16, 2),
(26, 17, 3),
(27, 18, 4),
(28, 19, 5),
(29, 20, 6),
(30, 21, 7),
(31, 22, 1),
(32, 23, 2),
(33, 24, 3),
(34, 25, 4),
(35, 26, 5),
(36, 27, 6),
(37, 28, 7),
(38, 29, 1),
(39, 30, 2),
(40, 31, 3),
(41, 32, 4),
(42, 33, 5),
(43, 34, 6),
(44, 35, 7),
(45, 36, 1),
(46, 37, 2),
(47, 38, 3),
(48, 39, 4),
(49, 40, 5),
(50, 41, 6),
(51, 42, 7),
(52, 43, 1),
(53, 44, 2),
(54, 45, 3),
(55, 46, 4),
(56, 47, 5),
(57, 48, 6),
(58, 49, 7),
(59, 50, 1),
(60, 54, 2),
(61, 55, 3),
(62, 56, 4),
(63, 57, 5),
(64, 59, 6),
(65, 60, 7),
(66, 61, 1),
(67, 62, 2),
(68, 63, 3),
(69, 64, 4),
(70, 65, 5),
(71, 66, 6),
(72, 67, 7),
(73, 68, 1),
(74, 69, 2),
(75, 1, 3),
(76, 2, 4),
(77, 3, 5),
(78, 4, 6),
(79, 5, 7),
(80, 6, 1),
(81, 7, 2),
(82, 8, 3),
(83, 9, 4),
(84, 10, 5),
(85, 11, 6),
(86, 12, 7),
(87, 13, 1),
(88, 14, 2),
(89, 15, 3),
(90, 16, 4),
(91, 17, 5),
(92, 18, 6),
(93, 19, 7),
(94, 20, 1),
(95, 21, 2),
(96, 22, 3),
(97, 23, 4),
(98, 24, 5),
(99, 25, 6),
(100, 26, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `ruc` varchar(15) DEFAULT NULL,
  `razon_social` varchar(50) DEFAULT NULL,
  `ubigeo_id` int(11) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `contacto` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `ruc`, `razon_social`, `ubigeo_id`, `direccion`, `telefono`, `correo`, `contacto`, `activo`) VALUES
(1, '10428255867', 'Prueba SAC', 2, 'Prueba', '999999999', 'prueba@gmail.com', 'Juan', 1),
(2, '20428255867', 'Importadora SAC', 4, 'Calle los Jazminez 12', '987456789', 'importadora@gmail.com', 'Carmen Reategui', 1),
(3, '10456287105', 'Exportadora SRL.', 4, 'Calle las Gardenias 555', '987789333', 'exportadora@gmail.com', 'Karina del Solar', 1),
(4, '20601234567', 'Autopartes Globales S.A.C.', 1, 'Av. Industrial 123', '987654321', 'ventas@autopartesglobales.com', 'Ernesto Paredes', 1),
(5, '20509876543', 'Lubricantes del Perú S.R.L.', 17, 'Calle Los Motores 456', '912345678', 'contacto@lubriperu.pe', 'Susana Horia', 1),
(6, '20601234567', 'Autopartes Globales S.A.C.', 1, 'Av. Industrial 123', '987654321', 'ventas@autopartesglobales.com', 'Ernesto Paredes', 1),
(7, '20509876543', 'Lubricantes del Perú S.R.L.', 17, 'Calle Los Motores 456', '912345678', 'contacto@lubriperu.pe', 'Susana Horia', 1),
(8, '10428255867', 'Prueba SAC', 2, 'Prueba', '999999999', 'prueba@gmail.com', 'Juan', 1),
(9, '20428255867', 'Importadora SAC', 4, 'Calle los Jazminez 12', '987456789', 'importadora@gmail.com', 'Carmen Reategui', 1),
(10, '10456287105', 'Exportadora SRL.', 4, 'Calle las Gardenias 555', '987789333', 'exportadora@gmail.com', 'Karina del Solar', 1),
(11, '20601234567', 'Autopartes Globales S.A.C.', 1, 'Av. Industrial 123', '987654321', 'ventas@autopartesglobales.com', 'Ernesto Paredes', 1),
(12, '20509876543', 'Lubricantes del Perú S.R.L.', 17, 'Calle Los Motores 456', '912345678', 'contacto@lubriperu.pe', 'Susana Horia', 1),
(13, '20601234567', 'Autopartes Globales S.A.C.', 1, 'Av. Industrial 123', '987654321', 'ventas@autopartesglobales.com', 'Ernesto Paredes', 1),
(14, '20509876543', 'Lubricantes del Perú S.R.L.', 17, 'Calle Los Motores 456', '912345678', 'contacto@lubriperu.pe', 'Susana Horia', 1),
(15, '10123456789', 'Repuestos Andinos S.A.', 3, 'Av. Panamericana Sur Km 10', '955123456', 'info@repuestosandinos.com', 'Carlos Mendoza', 1),
(16, '20987654321', 'Frenos y Servicios SAC', 5, 'Jr. Los Ficus 321', '944789123', 'contacto@frenosyservicios.com', 'Maria Torres', 1),
(17, '10234567890', 'Accesorios Vehiculares SRL', 12, 'Calle Principal 100', '933456789', 'ventas@accesoriosveh.com', 'Pedro Rojas', 1),
(18, '20345678901', 'Distribuidora Automotriz S.A.C.', 1, 'Av. La Molina 789', '922109876', 'distribucion@automotriz.com', 'Ana Quispe', 1),
(19, '10987123456', 'Neumáticos del Sur', 8, 'Carretera Central 500', '977654321', 'contacto@neumaticosdelsur.com', 'Luis Ramos', 1),
(20, '20112233445', 'Climatización Total E.I.R.L.', 1, 'Jr. Las Palmeras 200', '966543210', 'ventas@climatizaciontotal.com', 'Sofia Castro', 1),
(21, '10567890123', 'Electricidad Automotriz SAC', 17, 'Av. Ricardo Palma 333', '900112233', 'contacto@electauto.com', 'Roberto Salas', 1),
(22, '20778899001', 'Mecánica Avanzada SRL', 4, 'Calle Los Rosales 400', '911223344', 'admin@mecanicaavanzada.com', 'Daniel Gutierrez', 1),
(23, '10445566778', 'Autolujos Boutique', 2, 'Av. Pardo 800', '988776655', 'info@autolujos.com', 'Elena Vargas', 1),
(24, '20001122334', 'Servicios Automotrices Integrales', 1, 'Av. Argentina 150', '977889900', 'contacto@serviciosauto.com', 'Jorge Linares', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rol` varchar(50) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `rol`, `activo`) VALUES
(1, 'asistente', 1),
(2, 'mecánico', 1),
(3, 'administrador', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_permiso`
--

CREATE TABLE `rol_permiso` (
  `rol_id` int(11) NOT NULL,
  `permiso_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol_permiso`
--

INSERT INTO `rol_permiso` (`rol_id`, `permiso_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 7),
(1, 8),
(1, 9),
(1, 41),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 41),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 41);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `descuento` decimal(10,2) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `codigo`, `nombre`, `descripcion`, `descuento`, `precio`, `activo`) VALUES
(1, 'SRV001', 'Cambio de aceite', 'Servicio de cambio de aceite para motor', 5.00, 70.00, 1),
(2, 'SRV002', 'Alineamiento', 'Alineación y balanceo de las llantas', 0.00, 60.00, 1),
(3, 'SRV003', 'Revisión general', 'Inspección completa del vehículo', 10.00, 120.00, 1),
(4, 'SRV004', 'Cambio de frenos', 'Reemplazo de pastillas de freno', 0.00, 150.00, 1),
(5, 'SRV005', 'Lavado completo', 'Lavado exterior e interior del vehículo', 0.00, 40.00, 1),
(6, 'SRV006', 'Mantenimiento de sistema eléctrico', 'Servicio de revisión, diagnóstico y reparación del sistema eléctrico para garantizar el correcto funcionamiento y seguridad del vehículo', 25.00, 400.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubigeos`
--

CREATE TABLE `ubigeos` (
  `id` int(11) NOT NULL,
  `codigo` varchar(100) DEFAULT NULL,
  `ubigeo` varchar(6) NOT NULL,
  `departamento` varchar(50) NOT NULL,
  `provincia` varchar(50) NOT NULL,
  `distrito` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ubigeos`
--

INSERT INTO `ubigeos` (`id`, `codigo`, `ubigeo`, `departamento`, `provincia`, `distrito`) VALUES
(1, NULL, '150101', 'Lima', 'Lima', 'Lima'),
(2, NULL, '150102', 'Lima', 'Lima', 'Ancón'),
(3, NULL, '150103', 'Lima', 'Lima', 'Ate'),
(4, NULL, '150104', 'Lima', 'Lima', 'Barranco'),
(5, NULL, '150105', 'Lima', 'Lima', 'Breña'),
(6, NULL, '150106', 'Lima', 'Lima', 'Carabayllo'),
(7, NULL, '150107', 'Lima', 'Lima', 'Chaclacayo'),
(8, NULL, '150108', 'Lima', 'Lima', 'Chorrillos'),
(9, NULL, '150109', 'Lima', 'Lima', 'Cieneguilla'),
(10, NULL, '150110', 'Lima', 'Lima', 'Comas'),
(11, NULL, '150111', 'Lima', 'Lima', 'El Agustino'),
(12, NULL, '150112', 'Lima', 'Lima', 'Independencia'),
(13, NULL, '150113', 'Lima', 'Lima', 'Jesús María'),
(14, NULL, '150114', 'Lima', 'Lima', 'La Molina'),
(15, NULL, '150115', 'Lima', 'Lima', 'La Victoria'),
(16, NULL, '150116', 'Lima', 'Lima', 'Lince'),
(17, NULL, '150117', 'Lima', 'Lima', 'Los Olivos'),
(18, NULL, '150118', 'Lima', 'Lima', 'Lurigancho'),
(19, NULL, '150119', 'Lima', 'Lima', 'Lurín'),
(20, NULL, '150120', 'Lima', 'Lima', 'Magdalena del Mar'),
(21, NULL, '150121', 'Lima', 'Lima', 'Miraflores'),
(22, NULL, '150122', 'Lima', 'Lima', 'Pachacamac'),
(23, NULL, '150123', 'Lima', 'Lima', 'Pucusana'),
(24, NULL, '150124', 'Lima', 'Lima', 'Puente Piedra'),
(25, NULL, '150125', 'Lima', 'Lima', 'Rímac'),
(26, NULL, '070101', 'Callao', 'Callao', 'Callao'),
(27, NULL, '070102', 'Callao', 'Callao', 'Bellavista'),
(28, NULL, '070103', 'Callao', 'Callao', 'Carmen de la Legua Reynoso'),
(29, NULL, '070104', 'Callao', 'Callao', 'La Perla'),
(30, NULL, '070105', 'Callao', 'Callao', 'La Punta'),
(31, NULL, '070106', 'Callao', 'Callao', 'Ventanilla'),
(32, NULL, '070107', 'Callao', 'Callao', 'Mi Perú');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `persona_id` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  `rol_id` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `persona_id`, `email`, `password_hash`, `active`, `rol_id`, `last_login`) VALUES
(1, 52, 'quispeamet2@gmail.com', 'scrypt:32768:8:1$nZSr8WpOektsbwrM$afeff160f6c76df520161cc9283ea50f630e53898b230fa2694263fdca1e0047c4fad39bb048fe166c541edf7d21351fdf3e25855012f6fc86f1a509fa5c3d67', 1, 3, NULL),
(2, 53, 'josuesandovalherrera26@gmail.com', 'scrypt:32768:8:1$bwvmyefHI0GPMzhG$993aeb0bce6ab6e446b61ecef7ce90d29f475b596d0c3993cf63078b189274a42d6618b374aba43b39097a6a956d302e99b81020f4aad40c7b910c70b33e1384', 1, 3, NULL),
(3, 54, 'U20233784@utp.edu.pe', 'scrypt:32768:8:1$8sPzyTS2oMzs6ccS$44ea705bc8dab22cbe4f63177b1fc8cdad7207d276f713117ccaaea4af0f368ef57871ec0bac375e3ef79f158a18fdb30ce2dacdf0af4873f7f2c875c44f3cf7', 1, 1, NULL),
(4, 55, 'U23236416@UTP.EDU.PE', 'scrypt:32768:8:1$r0Hb9kLfZTPbXBK6$a12e792ae83aa817644e44f6f7e6df966ebbea58060c60558428e204d07dcca0651d3e18e7a7064caa9ba90d4bd808d4de67fee6e79bc1ad322d319f993e0dd1', 1, 2, NULL),
(5, 56, 'partfirebase12@gmail.com', 'scrypt:32768:8:1$24OYUqxE6bCE5yT5$a774f6102b3442342aed2e94fb799dc7e23832ed0ea08f1f023e91ed73714975d972379aa36da30d20f5d9a6cbf49ac29f2ecd3c94cd7e137a3417d72c326f6f', 1, 1, NULL),
(6, 57, 'quispeamet2@gmail.com', 'pbkdf2:sha256:260000$rUFz42nv3SYWQFnF$dd6d06cdd0d67fa803e9916d6e763d0b5b110cd259b0f0b6bc70a231b0ae3302', 1, 3, NULL),
(7, 58, 'quispeamet5@gmail.com', 'scrypt:32768:8:1$FOZe0SpcMNgiPWtZ$42e808aaa57682ec01cb80b51a32dc95a4265d728c2ea826e80f1527e394d2983b173b2b01a4f36a35eab5a478591f5b23b13d9ee661c7413bc215175e46e091', 1, 1, NULL),
(8, 1, 'testreset@mail.com', '$2b$12$KIXg6z7cXW7xS2bXeJZt2OJhIdWyM7L6GU5vGQ3F0f/1cRCtEtAiq', 1, 1, NULL),
(9, 151, 'quispeamet4@gmail.com', 'scrypt:32768:8:1$XcxZylHPkDgjdKST$f2cfdde79c98883f6d1ef33ba02520b48e86523900e810a42c73cde8e1e3244bbb57a25cc994e67769adfef7285b200b2fcda40e26f294573ac2f56ba669c3ad', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `cliente_id` int(11) NOT NULL,
  `automovil_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `estado_id` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `fecha_vencimiento` date DEFAULT NULL,
  `diagnostico` text DEFAULT NULL,
  `descuento_porcentaje` decimal(5,2) DEFAULT 0.00,
  `subtotal` decimal(10,2) DEFAULT 0.00,
  `descuento_monto` decimal(10,2) DEFAULT 0.00,
  `total_sin_igv` decimal(10,2) DEFAULT 0.00,
  `igv` decimal(10,2) DEFAULT 0.00,
  `total` decimal(10,2) DEFAULT 0.00,
  `observaciones` text DEFAULT NULL,
  `comprobante_estado` tinyint(1) DEFAULT NULL,
  `comprobante_tipo` varchar(20) DEFAULT NULL,
  `comprobante_Serie` varchar(5) DEFAULT NULL,
  `comprobante_numero` int(11) DEFAULT NULL,
  `comprobante_fecha` datetime DEFAULT NULL,
  `comprobante_usuario_id` int(11) DEFAULT NULL,
  `orden_estado` varchar(20) DEFAULT NULL,
  `orden_numero` varchar(15) DEFAULT NULL,
  `orden_fecha` datetime DEFAULT NULL,
  `orden_usuario_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `codigo`, `cliente_id`, `automovil_id`, `usuario_id`, `estado_id`, `fecha`, `fecha_vencimiento`, `diagnostico`, `descuento_porcentaje`, `subtotal`, `descuento_monto`, `total_sin_igv`, `igv`, `total`, `observaciones`, `comprobante_estado`, `comprobante_tipo`, `comprobante_Serie`, `comprobante_numero`, `comprobante_fecha`, `comprobante_usuario_id`, `orden_estado`, `orden_numero`, `orden_fecha`, `orden_usuario_id`) VALUES
(1, 'C001-00000001', 1, 4, 4, 1, '2025-06-23 23:59:48', '2025-06-26', '.', 10.00, 53.28, 5.33, 47.95, 8.63, 56.58, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'C001-00000002', 2, 7, 4, 1, '2025-06-24 00:03:27', '2025-06-25', '.', 0.00, 35.00, 0.00, 35.00, 6.30, 41.30, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'C001-00000003', 9, 1, 4, 1, '2025-06-24 21:56:18', '2025-06-30', '', 10.00, 52.25, 5.23, 47.02, 8.46, 55.48, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'C001-00000004', 6, 11, 4, 1, '2025-06-24 22:00:00', '2025-06-27', '', 10.00, 8.90, 0.89, 8.01, 1.44, 9.45, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'C001-00000005', 9, 4, 4, 1, '2025-06-24 22:01:35', '2025-06-29', '', 15.00, 76.50, 11.47, 65.03, 11.71, 76.74, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'C001-00000006', 5, 6, 4, 1, '2025-06-24 22:46:19', '2025-06-06', '', 10.00, 175.00, 17.50, 157.50, 28.35, 185.85, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'C001-00000007', 4, 2, 4, 1, '2025-06-25 00:40:31', '2025-06-27', '.', 0.00, 419.95, 0.00, 419.95, 75.59, 495.54, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'C001-00000008', 5, 5, 4, 1, '2025-06-25 00:42:27', '2025-07-02', '.', 10.00, 95.00, 0.00, 86.00, 17.10, 102.60, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'C001-00000009', 5, 5, 4, 1, '2025-06-25 00:50:37', '2025-07-04', '.', 10.00, 306.00, 30.60, 275.40, 49.57, 324.97, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'C001-00000010', 6, 17, 4, 1, '2025-06-25 08:33:38', '2025-06-30', '.', 5.00, 154.50, 7.73, 146.77, 26.42, 173.19, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'C001-00000011', 2, 3, 4, 1, '2025-06-25 22:04:54', '2025-07-01', '.', 0.00, 284.60, 0.00, 269.20, 48.46, 317.66, 'ghghghghg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'C001-00000012', 4, 3, 4, 1, '2025-06-26 11:54:16', '2025-06-30', '.', 0.00, 137.80, 0.00, 137.80, 24.80, 162.60, '.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'C001-00000013', 4, 9, 4, 1, '2025-06-26 12:45:18', '2025-07-02', '.', 0.00, 240.00, 0.00, 240.00, 43.20, 283.20, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'C001-00000014', 9, 16, 4, 7, '2025-06-26 13:04:40', '2025-07-02', '', 0.00, 1000.50, 0.00, 287.50, 51.75, 339.25, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'C001-00000015', 2, 3, 4, 7, '2025-06-26 17:25:18', '2025-07-02', '', 0.00, 128.90, 0.00, 178.90, 32.20, 211.10, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'C001-00000016', 7, 7, 4, 7, '2025-06-26 21:50:14', '2025-06-27', '', 10.00, 329.00, 32.90, 296.10, 53.30, 349.40, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'C001-00000017', 2, 10, 4, 7, '2025-06-26 21:55:50', '2025-06-30', '', 0.00, 190.00, 0.00, 190.00, 34.20, 224.20, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'C001-00000018', 8, 8, 2, 3, '2025-07-05 09:30:00', '2025-07-12', 'Frenos largos y ruido al frenar.', 0.00, 410.50, 0.00, 410.50, 73.89, 484.39, 'Requiere cambio de pastillas y rectificación de discos.', NULL, NULL, NULL, NULL, NULL, NULL, 'En curso', 'OT001-0001', '2025-07-05 10:00:00', 2),
(21, 'C001-00000019', 15, 15, 4, 7, '2025-07-06 11:00:00', '2025-07-10', 'Mantenimiento preventivo de 40,000 km.', 5.00, 244.99, 12.25, 232.74, 41.89, 274.63, 'Cliente solicitó adicionalmente un ambientador.', 1, 'Boleta', 'B001', 101, '2025-07-06 14:00:00', 4, NULL, NULL, NULL, NULL),
(22, 'C001-00000020', 20, 20, 4, 1, '2025-07-07 15:00:00', '2025-07-14', 'Vehículo no enciende, posible falla de batería o alternador.', 0.00, 190.00, 0.00, 0.00, 0.00, 224.20, 'Pendiente de aprobación del cliente.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'C001-00000021', 1, 53, 2, 7, '2025-07-08 10:00:00', '2025-07-15', 'Cambio de 2 llantas delanteras por desgaste.', 0.00, 820.00, 0.00, 820.00, 147.60, 967.60, 'Se realizó alineamiento y balanceo.', 1, 'Factura', 'F001', 55, '2025-07-08 18:00:00', 4, 'Finalizado', 'OT001-0002', '2025-07-08 10:30:00', 2),
(108, 'C001-00000108', 10, 1, 2, 1, '2025-08-21 09:00:00', '2025-08-28', 'Diagnóstico de sistema de enfriamiento.', 0.00, 70.00, 0.00, 70.00, 12.60, 82.60, 'Sobrecalentamiento del motor.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 'C001-00000151', 1, 4, 2, 1, '2025-09-11 15:00:00', '2025-09-18', 'Revisión de sistema de inyección.', 0.00, 150.00, 0.00, 150.00, 27.00, 177.00, 'Falla en un inyector.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 'C001-00000152', 8, 19, 4, 7, '2025-09-12 09:00:00', '2025-09-19', 'Cambio de pastillas de freno delanteras.', 5.00, 180.00, 9.00, 171.00, 30.78, 201.78, 'Pastillas con 95% de desgaste.', 1, 'Boleta', 'B001', 132, '2025-09-12 11:00:00', 4, NULL, NULL, NULL, NULL),
(111, 'C001-00000153', 11, 20, 7, 1, '2025-09-12 11:30:00', '2025-09-19', 'Diagnóstico de ruidos en el motor.', 0.00, 100.00, 0.00, 100.00, 18.00, 118.00, 'Ruido de válvula. Necesita inspección a fondo.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 'C001-00000154', 14, 5, 2, 1, '2025-09-13 14:00:00', '2025-09-20', 'Revisión de luces de freno y reversa.', 0.00, 40.00, 0.00, 40.00, 7.20, 47.20, 'Foco de freno derecho quemado.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 'C001-00000155', 2, 13, 4, 7, '2025-09-13 16:00:00', '2025-09-20', 'Mantenimiento de 150,000 km.', 0.00, 1300.00, 0.00, 1300.00, 234.00, 1534.00, 'Mantenimiento completo de motor y transmisión.', 1, 'Factura', 'F001', 73, '2025-09-13 18:00:00', 7, NULL, NULL, NULL, NULL),
(114, 'C001-00000156', 5, 18, 7, 1, '2025-09-14 09:00:00', '2025-09-21', 'Cambio de batería.', 0.00, 120.00, 0.00, 120.00, 21.60, 141.60, 'Batería con bajo voltaje.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 'C001-00000157', 7, 3, 2, 1, '2025-09-14 11:30:00', '2025-09-21', 'Revisión de sistema de aire acondicionado.', 5.00, 150.00, 7.50, 142.50, 25.65, 168.15, 'Necesita recarga de gas.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 'C001-00000158', 9, 9, 4, 7, '2025-09-15 14:00:00', '2025-09-22', 'Diagnóstico de falla eléctrica.', 0.00, 80.00, 0.00, 80.00, 14.40, 94.40, 'Cortocircuito en luces interiores.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 'C001-00000159', 12, 15, 7, 1, '2025-09-15 16:00:00', '2025-09-22', 'Cambio de filtro de combustible.', 0.00, 45.00, 0.00, 45.00, 8.10, 53.10, NULL, 1, 'Boleta', 'B001', 133, '2025-09-15 17:30:00', 2, NULL, NULL, NULL, NULL),
(118, 'C001-00000160', 15, 1, 2, 1, '2025-09-16 09:00:00', '2025-09-23', 'Revisión de suspensión delantera.', 10.00, 200.00, 20.00, 180.00, 32.40, 212.40, 'Ruido al pasar baches.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 'C001-00000161', 3, 10, 4, 7, '2025-09-16 11:30:00', '2025-09-23', 'Mantenimiento de 160,000 km.', 0.00, 1400.00, 0.00, 1400.00, 252.00, 1652.00, 'Revisión completa de motor.', 1, 'Factura', 'F001', 74, '2025-09-16 13:00:00', 4, NULL, NULL, NULL, NULL),
(120, 'C001-00000162', 6, 16, 7, 1, '2025-09-17 14:00:00', '2025-09-24', 'Diagnóstico de dirección asistida.', 0.00, 100.00, 0.00, 100.00, 18.00, 118.00, 'Siente la dirección dura.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 'C001-00000163', 10, 1, 2, 1, '2025-09-17 16:00:00', '2025-09-24', 'Cambio de líquido de frenos.', 0.00, 40.00, 0.00, 40.00, 7.20, 47.20, NULL, 1, 'Boleta', 'B001', 134, '2025-09-17 17:30:00', 7, NULL, NULL, NULL, NULL),
(122, 'C001-00000165', 1, 14, 7, 1, '2025-09-18 11:30:00', '2025-09-25', 'Mantenimiento de 170,000 km.', 0.00, 1500.00, 0.00, 1500.00, 270.00, 1770.00, 'Reemplazo de correas y fluidos.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(123, 'C001-00000166', 8, 19, 2, 1, '2025-09-19 14:00:00', '2025-09-26', 'Diagnóstico de sistema de encendido.', 0.00, 90.00, 0.00, 90.00, 16.20, 106.20, 'Falla en bujías y bobinas.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 'C001-00000167', 11, 20, 4, 7, '2025-09-19 16:00:00', '2025-09-26', 'Cambio de bujías.', 0.00, 70.00, 0.00, 70.00, 12.60, 82.60, NULL, 1, 'Boleta', 'B001', 135, '2025-09-19 17:30:00', 4, NULL, NULL, NULL, NULL),
(125, 'C001-00000168', 14, 5, 7, 1, '2025-09-20 09:00:00', '2025-09-27', 'Revisión de neumáticos y presión.', 5.00, 20.00, 1.00, 19.00, 3.42, 22.42, 'Neumáticos desinflados.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(126, 'C001-00000169', 2, 13, 2, 1, '2025-09-20 10:30:00', '2025-09-27', 'Mantenimiento de 180,000 km.', 0.00, 1600.00, 0.00, 1600.00, 288.00, 1888.00, 'Revisión y reemplazo de componentes críticos.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 'C001-00000170', 5, 18, 4, 7, '2025-09-21 14:00:00', '2025-09-28', 'Diagnóstico de ruidos en la transmisión.', 0.00, 120.00, 0.00, 120.00, 21.60, 141.60, 'Ruido al cambiar de marcha. Posible desgaste de engranajes.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 'C001-00000191', 10, 4, 4, 4, '2025-07-26 14:10:00', '2025-08-20', 'Reemplazo de neumáticos.', 2.40, 191.80, 11.52, 71.71, 43.02, 292.91, 'Pendiente aprobación de repuestos.', NULL, NULL, 'B009', NULL, '2025-08-09 20:00:00', 6, NULL, 'OT002-0028', '2025-08-14 10:11:00', 6),
(222, 'C001-00000192', 13, 11, 6, 2, '2025-07-03 20:30:00', '2025-09-01', 'Cambio de aceite y filtro.', 14.52, 104.63, 15.19, 207.03, 45.49, 222.16, NULL, NULL, 'Factura', NULL, 184, '2025-08-23 18:03:00', 1, NULL, 'OT004-0032', '2025-07-16 16:33:00', 3),
(223, 'C001-00000193', 2, 5, 7, 4, '2025-07-16 18:22:00', '2025-08-22', 'Revisión de frenos y pastillas.', 5.90, 125.28, 17.25, 245.41, 19.46, 216.91, 'Se realizó alineación y balanceo.', 3, NULL, 'B009', 191, '2025-08-09 17:12:00', NULL, 'Pendiente', 'OT004-0070', '2025-08-09 06:00:00', 7),
(224, 'C001-00000194', 18, 12, 1, 4, '2025-07-07 11:59:00', '2025-09-06', 'Revisión de frenos y pastillas.', 5.86, 37.01, 3.36, 124.21, 30.70, 365.02, NULL, 4, NULL, 'B001', NULL, NULL, NULL, NULL, 'OT004-0030', NULL, NULL),
(225, 'C001-00000195', 10, 19, 2, 2, '2025-07-21 13:23:00', '2025-09-30', 'Cambio de aceite y filtro.', 14.02, 70.39, 1.10, 205.46, 14.53, 194.27, 'Cliente solicitó lavado de motor.', 4, 'Factura', NULL, 27, NULL, NULL, 'Finalizado', 'OT008-0080', '2025-07-31 21:08:00', NULL),
(226, 'C001-00000196', 5, 18, 5, 3, '2025-08-28 17:48:00', '2025-07-08', 'Revisión de frenos y pastillas.', 0.32, 149.49, 2.83, 64.62, 30.14, 218.91, NULL, 1, 'Factura', 'B004', 180, '2025-07-19 00:01:00', 5, NULL, 'OT005-0006', NULL, NULL),
(227, 'C001-00000197', 18, 10, 6, 2, '2025-08-13 02:29:00', '2025-08-01', 'Cambio de aceite y filtro.', 10.54, 59.44, 16.51, 114.97, 6.71, 260.06, 'Fuga menor detectada y reparada.', NULL, NULL, NULL, 63, '2025-07-03 03:30:00', 4, 'Finalizado', NULL, NULL, NULL),
(228, 'C001-00000198', 1, 13, 2, 4, '2025-09-12 05:58:00', '2025-08-17', 'Cambio de aceite y filtro.', 8.84, 294.51, 24.20, 95.59, 0.97, 131.69, 'Cliente solicitó lavado de motor.', 4, 'Boleta', NULL, 78, '2025-08-21 15:47:00', NULL, NULL, 'OT002-0093', NULL, 1),
(229, 'C001-00000199', 15, 10, 1, 4, '2025-08-24 02:16:00', '2025-07-14', 'Reemplazo de neumáticos.', 5.21, 182.14, 19.79, 204.52, 20.26, 398.56, NULL, 4, 'Boleta', 'B006', 79, NULL, 5, 'Pendiente', NULL, NULL, NULL),
(230, 'C001-00000200', 19, 16, 2, 3, '2025-08-31 18:57:00', '2025-08-13', 'Cambio de aceite y filtro.', 5.06, 109.93, 14.62, 165.34, 11.15, 226.38, 'Pendiente aprobación de repuestos.', 1, 'Boleta', NULL, 173, '2025-08-13 13:29:00', 3, NULL, NULL, '2025-07-17 06:16:00', NULL),
(231, 'C001-00000201', 8, 8, 6, 4, '2025-09-11 20:35:00', '2025-08-18', 'Cambio de aceite y filtro.', 12.13, 280.01, 27.22, 277.35, 48.13, 50.80, 'Cliente solicitó lavado de motor.', 3, 'Factura', 'B007', NULL, '2025-09-17 01:14:00', 1, NULL, NULL, NULL, NULL),
(232, 'C001-00000202', 9, 13, 6, 1, '2025-09-07 23:49:00', '2025-09-13', 'Reemplazo de neumáticos.', 10.86, 254.09, 21.90, 101.59, 17.81, 348.50, 'Cliente solicitó lavado de motor.', NULL, 'Boleta', NULL, NULL, '2025-09-26 13:31:00', NULL, NULL, 'OT001-0021', '2025-08-29 09:37:00', 5),
(233, 'C001-00000203', 17, 7, 2, 4, '2025-08-04 18:54:00', '2025-08-30', 'Mantenimiento general de 10.000km.', 14.79, 24.17, 3.37, 160.59, 13.15, 314.12, 'Pendiente aprobación de repuestos.', 2, 'Factura', 'B007', NULL, NULL, 2, NULL, 'OT010-0028', '2025-09-04 19:40:00', NULL),
(234, 'C001-00000204', 7, 6, 4, 3, '2025-07-12 16:47:00', '2025-08-10', 'Reemplazo de neumáticos.', 1.24, 148.47, 26.82, 66.71, 12.09, 279.09, 'Fuga menor detectada y reparada.', 1, 'Boleta', 'B010', 170, NULL, NULL, NULL, 'OT007-0072', '2025-08-24 19:26:00', NULL),
(235, 'C001-00000205', 1, 1, 7, 3, '2025-09-11 09:16:00', '2025-09-16', 'Reemplazo de neumáticos.', 0.01, 298.72, 19.31, 135.61, 11.15, 337.82, 'Fuga menor detectada y reparada.', 2, 'Factura', 'B006', 158, NULL, NULL, NULL, 'OT006-0035', NULL, 6),
(236, 'C001-00000206', 11, 2, 7, 2, '2025-07-01 08:42:00', '2025-09-26', 'Reemplazo de neumáticos.', 6.73, 110.54, 4.87, 268.63, 2.12, 223.07, 'Se realizó alineación y balanceo.', NULL, NULL, NULL, NULL, '2025-08-30 09:38:00', 2, 'Finalizado', 'OT009-0093', NULL, 6),
(237, 'C001-00000207', 19, 8, 1, 1, '2025-08-24 00:44:00', '2025-08-23', 'Mantenimiento general de 10.000km.', 1.45, 211.83, 27.22, 188.20, 18.54, 399.32, 'Pendiente aprobación de repuestos.', NULL, NULL, 'B007', 82, '2025-09-09 07:59:00', 1, 'En curso', 'OT002-0082', '2025-07-24 04:05:00', NULL),
(238, 'C001-00000208', 10, 4, 3, 3, '2025-08-19 05:59:00', '2025-07-10', 'Reemplazo de neumáticos.', 4.50, 140.14, 3.08, 102.54, 12.74, 167.63, 'Pendiente aprobación de repuestos.', 1, 'Factura', 'B004', NULL, NULL, 1, 'Pendiente', NULL, NULL, NULL),
(239, 'C001-00000209', 17, 2, 7, 2, '2025-07-24 13:17:00', '2025-07-08', 'Diagnóstico de sistema eléctrico.', 0.07, 245.07, 22.09, 135.65, 47.28, 202.22, 'Se realizó alineación y balanceo.', NULL, 'Boleta', NULL, NULL, NULL, NULL, 'Pendiente', NULL, NULL, NULL),
(240, 'C001-00000210', 4, 9, 5, 4, '2025-07-21 09:15:00', '2025-09-03', 'Reemplazo de neumáticos.', 6.13, 317.58, 22.00, 208.24, 12.56, 114.93, 'Cliente solicitó lavado de motor.', NULL, NULL, NULL, NULL, '2025-07-15 17:34:00', 3, NULL, NULL, NULL, 1),
(241, 'C001-00000211', 4, 10, 6, 3, '2025-07-21 02:39:00', '2025-09-20', 'Reemplazo de neumáticos.', 11.44, 259.02, 20.86, 39.26, 17.36, 216.50, 'Se realizó alineación y balanceo.', NULL, NULL, 'B004', 116, '2025-07-09 05:30:00', NULL, NULL, 'OT009-0079', NULL, NULL),
(242, 'C001-00000212', 10, 10, 7, 1, '2025-08-09 23:46:00', '2025-07-19', 'Diagnóstico de sistema eléctrico.', 14.91, 163.59, 12.34, 188.64, 43.35, 216.22, NULL, NULL, 'Boleta', 'B005', NULL, '2025-09-02 14:07:00', 6, NULL, NULL, NULL, NULL),
(243, 'C001-00000213', 7, 6, 3, 1, '2025-08-13 01:13:00', '2025-09-30', 'Diagnóstico de sistema eléctrico.', 4.75, 91.79, 7.40, 159.29, 41.83, 273.09, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-07-23 04:02:00', NULL),
(244, 'C001-00000214', 16, 13, 7, 2, '2025-07-16 17:40:00', '2025-09-15', 'Diagnóstico de sistema eléctrico.', 3.56, 196.60, 6.92, 123.26, 12.08, 66.93, 'Fuga menor detectada y reparada.', NULL, 'Factura', 'B004', NULL, NULL, NULL, NULL, NULL, NULL, 5),
(245, 'C001-00000215', 6, 8, 1, 3, '2025-08-05 05:56:00', '2025-07-27', 'Cambio de aceite y filtro.', 11.60, 183.44, 12.13, 123.27, 36.04, 205.34, 'Cliente solicitó lavado de motor.', 3, NULL, 'B005', NULL, '2025-07-17 06:32:00', NULL, 'Finalizado', NULL, NULL, 4),
(246, 'C001-00000216', 20, 5, 2, 1, '2025-08-08 00:41:00', '2025-08-22', 'Diagnóstico de sistema eléctrico.', 10.36, 37.38, 6.56, 272.44, 47.06, 381.75, 'Pendiente aprobación de repuestos.', 4, NULL, NULL, NULL, '2025-07-30 00:03:00', 5, 'En curso', NULL, NULL, 3),
(247, 'C001-00000217', 5, 4, 2, 2, '2025-08-07 09:30:00', '2025-09-21', 'Cambio de aceite y filtro.', 14.54, 169.95, 17.71, 141.50, 24.41, 79.93, 'Pendiente aprobación de repuestos.', 4, 'Factura', NULL, NULL, NULL, 2, NULL, 'OT005-0032', NULL, NULL),
(248, 'C001-00000218', 1, 18, 2, 2, '2025-07-08 04:40:00', '2025-08-10', 'Reemplazo de neumáticos.', 10.91, 102.21, 5.65, 48.66, 1.78, 336.22, 'Pendiente aprobación de repuestos.', NULL, NULL, NULL, NULL, '2025-08-04 21:25:00', NULL, 'Finalizado', 'OT010-0017', '2025-07-07 15:25:00', 6),
(249, 'C001-00000219', 7, 3, 5, 4, '2025-07-31 08:47:00', '2025-07-14', 'Diagnóstico de sistema eléctrico.', 6.12, 139.53, 23.03, 195.03, 45.60, 270.74, 'Fuga menor detectada y reparada.', NULL, 'Boleta', NULL, NULL, '2025-07-12 14:21:00', NULL, 'En curso', 'OT002-0039', '2025-09-19 18:14:00', 4),
(250, 'C001-00000220', 15, 2, 1, 1, '2025-09-16 03:17:00', '2025-08-29', 'Diagnóstico de sistema eléctrico.', 12.82, 212.83, 19.50, 105.30, 33.10, 169.83, NULL, 4, NULL, NULL, 177, '2025-09-04 20:58:00', 7, 'Finalizado', 'OT005-0063', '2025-09-10 10:30:00', 3),
(251, 'C001-00000221', 14, 6, 3, 3, '2025-09-10 22:54:00', '2025-09-09', 'Revisión de frenos y pastillas.', 3.12, 78.49, 10.51, 61.74, 39.18, 195.95, NULL, NULL, 'Boleta', NULL, 15, NULL, NULL, 'Finalizado', 'OT004-0075', '2025-08-01 01:09:00', 6),
(252, 'C001-00000222', 4, 12, 4, 2, '2025-08-22 16:38:00', '2025-09-13', 'Cambio de aceite y filtro.', 6.78, 255.35, 16.97, 147.96, 33.86, 386.53, NULL, 3, NULL, NULL, 119, NULL, NULL, 'En curso', NULL, NULL, NULL),
(253, 'C001-00000223', 20, 8, 1, 4, '2025-08-02 18:15:00', '2025-07-21', 'Mantenimiento general de 10.000km.', 7.63, 55.31, 1.88, 283.91, 30.69, 115.84, 'Cliente solicitó lavado de motor.', 2, 'Factura', NULL, 135, '2025-09-04 09:28:00', 5, NULL, NULL, '2025-07-19 14:38:00', NULL),
(254, 'C001-00000224', 7, 11, 4, 1, '2025-08-22 04:12:00', '2025-07-16', 'Mantenimiento general de 10.000km.', 3.40, 128.70, 3.96, 175.45, 23.45, 269.19, NULL, 3, NULL, 'B001', NULL, NULL, NULL, NULL, NULL, '2025-08-18 06:16:00', 2),
(255, 'C001-00000225', 3, 3, 2, 3, '2025-07-31 07:56:00', '2025-09-25', 'Diagnóstico de sistema eléctrico.', 2.97, 85.82, 15.08, 254.25, 38.24, 141.10, 'Cliente solicitó lavado de motor.', NULL, NULL, 'B008', NULL, '2025-09-29 01:32:00', NULL, 'Finalizado', NULL, NULL, NULL),
(256, 'C001-00000226', 2, 13, 7, 4, '2025-09-18 14:56:00', '2025-08-21', 'Cambio de aceite y filtro.', 7.13, 120.07, 7.29, 74.78, 16.95, 68.98, 'Se realizó alineación y balanceo.', NULL, 'Factura', 'B010', NULL, '2025-09-01 12:06:00', NULL, 'En curso', 'OT009-0067', '2025-08-27 23:20:00', NULL),
(257, 'C001-00000227', 4, 17, 5, 2, '2025-08-27 04:00:00', '2025-09-07', 'Reemplazo de neumáticos.', 4.08, 112.52, 21.78, 212.52, 17.44, 269.57, 'Cliente solicitó lavado de motor.', 3, NULL, NULL, 51, NULL, 1, NULL, NULL, NULL, 1),
(258, 'C001-00000228', 3, 6, 1, 3, '2025-07-21 08:41:00', '2025-09-29', 'Cambio de aceite y filtro.', 10.65, 80.53, 26.37, 235.92, 15.42, 111.36, 'Pendiente aprobación de repuestos.', NULL, NULL, 'B001', 97, '2025-08-24 07:23:00', NULL, NULL, 'OT007-0006', NULL, NULL),
(259, 'C001-00000229', 11, 11, 1, 4, '2025-08-02 12:16:00', '2025-09-29', 'Reemplazo de neumáticos.', 11.98, 254.96, 15.59, 84.62, 34.21, 286.43, 'Se realizó alineación y balanceo.', 1, NULL, NULL, 120, '2025-08-29 07:38:00', 1, 'En curso', NULL, '2025-09-01 00:30:00', 7),
(260, 'C001-00000230', 1, 5, 1, 3, '2025-09-08 02:23:00', '2025-07-11', 'Cambio de aceite y filtro.', 0.29, 309.36, 22.93, 274.82, 17.33, 382.35, NULL, 2, 'Factura', 'B005', 117, NULL, 7, 'Finalizado', NULL, '2025-08-26 14:54:00', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_productos`
--

CREATE TABLE `ventas_productos` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `descuento_porcentaje` decimal(10,2) DEFAULT NULL,
  `descuento_monto` decimal(10,2) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_productos`
--

INSERT INTO `ventas_productos` (`id`, `venta_id`, `producto_id`, `descripcion`, `cantidad`, `precio_unitario`, `descuento_porcentaje`, `descuento_monto`, `costo`, `activo`) VALUES
(1, 1, 4, 'Soporte de celular', 1, 15.00, 10.00, 0.00, 0.00, 0),
(2, 1, 8, 'Bombilla LED H4', 2, 22.10, 10.00, 0.00, 3.42, 0),
(3, 3, 6, 'Paño de microfibra', 10, 5.50, 5.00, 0.00, 0.00, 0),
(4, 5, 2, 'Ambientador de auto', 1, 8.90, 0.00, 0.00, 8.29, 0),
(5, 6, 17, 'Inyector de combustible', 1, 85.00, 10.00, 8.50, 0.00, 0),
(7, 8, 6, 'Paño de microfibra', 10, 5.50, 0.00, 0.00, 0.00, 0),
(8, 8, 20, 'Kit de seguridad', 1, 35.00, 10.00, 3.50, 0.00, 0),
(9, 9, 5, 'Aceite sintético 5W30', 5, 39.99, 2.00, 0.80, 0.00, 0),
(10, 9, 14, 'Parlante 6x9', 2, 50.00, 10.00, 5.00, 250.00, 0),
(11, 10, 6, 'Paño de microfibra', 10, 5.50, 0.00, 0.00, 0.00, 0),
(12, 11, 19, 'Disco de embrague', 2, 95.00, 10.00, 9.50, 29.00, 1),
(13, 12, 9, 'Sensor de oxígeno', 1, 45.00, 10.00, 4.50, 0.00, 1),
(14, 13, 6, 'Paño de microfibra', 15, 5.50, 0.00, 0.00, 0.00, 1),
(15, 13, 6, 'Paño de microfibra', 15, 5.50, 0.00, 0.00, 0.00, 0),
(16, 10, 6, 'Paño de microfibra', 10, 5.50, 0.00, 0.00, 0.00, 1),
(17, 14, 2, 'Ambientador de auto', 1, 8.90, 0.00, 0.00, 8.29, 1),
(18, 14, 2, 'Ambientador de auto', 1, 8.90, 0.00, 0.00, 8.29, 1),
(19, 13, 6, 'Paño de microfibra', 15, 5.50, 0.00, 0.00, 0.00, 0),
(20, 13, 8, 'Bombilla LED H4', 1, 22.10, 0.00, 0.00, 0.00, 1),
(21, 13, 6, 'Paño de microfibra', 15, 5.50, 0.00, 0.00, 0.00, 1),
(22, 13, 8, 'Bombilla LED H4', 1, 22.10, 0.00, 0.00, 0.00, 1),
(23, 1, 4, 'Soporte de celular', 1, 15.00, 0.00, 1.50, 0.00, 1),
(24, 1, 8, 'Bombilla LED H4', 2, 22.10, 0.00, 4.42, 0.00, 1),
(25, 2, 20, 'Kit de seguridad', 1, 35.00, 0.00, 0.00, 0.00, 1),
(26, 3, 6, 'Paño de microfibra', 10, 5.50, 0.00, 2.75, 0.00, 1),
(27, 5, 2, 'Ambientador de auto', 1, 8.90, 0.00, 0.00, 0.00, 1),
(28, 6, 17, 'Inyector de combustible', 1, 85.00, 0.00, 8.50, 0.00, 1),
(29, 8, 6, 'Paño de microfibra', 10, 5.50, 0.00, 0.00, 0.00, 0),
(30, 8, 20, 'Kit de seguridad', 1, 35.00, 0.00, 3.50, 0.00, 0),
(31, 9, 5, 'Aceite sintético 5W30', 5, 39.99, 0.00, 4.00, 0.00, 0),
(32, 9, 14, 'Parlante 6x9', 2, 50.00, 0.00, 10.00, 0.00, 0),
(33, 9, 5, 'Aceite sintético 5W30', 5, 39.99, 0.00, 0.00, 0.00, 1),
(34, 9, 14, 'Parlante 6x9', 2, 50.00, 0.00, 0.00, 0.00, 1),
(35, 8, 6, 'Paño de microfibra', 10, 5.50, 0.00, 0.00, 0.00, 1),
(36, 15, 3, 'Bujía estándar', 10, 12.00, 0.00, 0.00, 0.00, 1),
(37, 15, 3, 'Bujía estándar', 5, 12.00, 0.00, 0.00, 11.25, 1),
(38, 16, 2, 'Ambientador de auto', 10, 8.90, 0.00, 0.00, 8.29, 0),
(39, 16, 8, 'Bombilla LED H4', 15, 22.10, 0.00, 0.00, 0.00, 0),
(40, 16, 14, 'Parlante 6x9', 2, 50.00, 10.00, 10.00, 0.00, 0),
(41, 16, 8, 'Bombilla LED H4', 15, 22.10, 0.00, 0.00, 0.00, 0),
(42, 16, 14, 'Parlante 6x9', 2, 50.00, 0.00, 10.00, 0.00, 0),
(43, 16, 8, 'Bombilla LED H4', 15, 22.10, 0.00, 0.00, 0.00, 0),
(44, 16, 14, 'Parlante 6x9', 2, 50.00, 0.00, 10.00, 0.00, 0),
(45, 17, 2, 'Ambientador de auto', 1, 8.90, 0.00, 0.00, 0.00, 1),
(46, 17, 14, 'Parlante 6x9', 1, 50.00, 0.00, 0.00, 0.00, 1),
(47, 17, 18, 'Altavoz bluetooth', 1, 60.00, 0.00, 0.00, 0.00, 0),
(48, 16, 1, 'Filtro de aceite', 5, 25.50, 0.00, 0.00, 0.00, 1),
(49, 18, 8, 'Bombilla LED H4', 10, 22.10, 0.00, 0.00, 0.00, 1),
(50, 19, 4, 'Soporte de celular', 10, 15.00, 0.00, 0.00, 2.50, 1),
(51, 20, 1, 'Filtro de aceite Bosch', 1, 25.50, NULL, NULL, NULL, 1),
(52, 23, 62, 'Llanta Aro 15 Michelin', 2, 350.00, NULL, NULL, NULL, 1),
(53, 26, 11, 'Pastilla de freno delantera', 2, 30.50, NULL, NULL, NULL, 1),
(54, 26, 41, 'Líquido de frenos DOT4 Mobil', 1, 9.60, NULL, NULL, NULL, 1),
(55, 29, 61, 'Aditivo para motor Liqui Moly', 1, 45.00, NULL, NULL, NULL, 1),
(56, 29, 2, 'Ambientador de auto 3M', 1, 8.90, NULL, NULL, NULL, 1),
(57, 30, 29, 'Termostato ACDelco', 1, 26.50, NULL, NULL, NULL, 1),
(58, 32, 64, 'Correa de distribución Gates', 1, 120.00, NULL, NULL, NULL, 1),
(59, 34, 3, 'Bujía estándar NGK', 4, 12.00, NULL, NULL, NULL, 1),
(60, 34, 39, 'Grasa multiuso Castrol', 1, 6.80, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_servicios`
--

CREATE TABLE `ventas_servicios` (
  `id` int(11) NOT NULL,
  `venta_id` int(11) NOT NULL,
  `servicio_id` int(11) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1,
  `precio_unitario` decimal(10,2) NOT NULL,
  `descuento_porcentaje` decimal(5,2) DEFAULT 0.00,
  `subtotal` decimal(10,2) GENERATED ALWAYS AS ((`precio_unitario` - `precio_unitario` * `descuento_porcentaje` / 100) * `cantidad`) STORED,
  `descuento_monto` decimal(10,2) DEFAULT 0.00,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_servicios`
--

INSERT INTO `ventas_servicios` (`id`, `venta_id`, `servicio_id`, `descripcion`, `cantidad`, `precio_unitario`, `descuento_porcentaje`, `descuento_monto`, `activo`) VALUES
(1, 8, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 0),
(2, 9, 3, 'Revisión general', 1, 120.00, 10.00, 12.00, 0),
(3, 10, 5, 'Lavado completo', 1, 40.00, 0.00, 0.00, 0),
(4, 11, 4, 'Cambio de frenos', 1, 150.00, 10.00, 15.00, 1),
(5, 12, 3, 'Revisión general', 1, 120.00, 5.00, 6.00, 1),
(6, 10, 5, 'Lavado completo', 1, 40.00, 0.00, 0.00, 1),
(7, 14, 2, 'Alineamiento', 1, 60.00, 0.00, 0.00, 1),
(8, 14, 2, 'Alineamiento', 1, 60.00, 0.00, 0.00, 1),
(9, 13, 2, 'Alineamiento', 1, 60.00, 0.00, 0.00, 1),
(10, 13, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 0),
(11, 13, 2, 'Alineamiento', 1, 60.00, 0.00, 0.00, 1),
(12, 13, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 0),
(13, 8, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 0),
(14, 9, 3, 'Revisión general', 1, 120.00, 0.00, 12.00, 0),
(15, 9, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(16, 8, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(17, 15, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(18, 15, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(19, 16, 2, 'Alineamiento', 1, 60.00, 0.00, 0.00, 0),
(20, 16, 1, 'Cambio de aceite', 1, 70.00, 0.00, 0.00, 0),
(21, 16, 6, 'Mantenimiento de sistema eléctrico', 1, 400.00, 10.00, 40.00, 0),
(22, 16, 1, 'Cambio de aceite', 1, 70.00, 0.00, 0.00, 0),
(23, 16, 6, 'Mantenimiento de sistema eléctrico', 1, 400.00, 0.00, 40.00, 0),
(24, 16, 1, 'Cambio de aceite', 1, 70.00, 0.00, 0.00, 0),
(25, 16, 6, 'Mantenimiento de sistema eléctrico', 1, 400.00, 0.00, 40.00, 0),
(26, 17, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(27, 16, 5, 'Lavado completo', 1, 40.00, 0.00, 0.00, 1),
(28, 16, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(29, 18, 3, 'Revisión general', 1, 120.00, 10.00, 12.00, 1),
(30, 19, 5, 'Lavado completo', 1, 40.00, 0.00, 0.00, 1),
(31, 20, 1, 'Servicio de cambio de aceite', 1, 70.00, 0.00, 0.00, 1),
(32, 21, 4, 'Cambio de amortiguadores (no listado)', 1, 205.00, 0.00, 0.00, 1),
(33, 23, 2, 'Alineamiento y balanceo', 1, 60.00, 0.00, 0.00, 1),
(34, 24, 5, 'Lavado completo', 1, 40.00, 0.00, 0.00, 1),
(35, 24, 5, 'Encerado (no listado)', 1, 40.00, 0.00, 0.00, 1),
(36, 25, 3, 'Revisión general con escaner', 1, 120.00, 0.00, 0.00, 1),
(37, 26, 4, 'Cambio de frenos', 1, 150.00, 0.00, 0.00, 1),
(38, 27, 6, 'Revisión de sistema eléctrico', 1, 400.00, 0.00, 0.00, 1),
(39, 28, 3, 'Revisión general', 1, 120.00, 0.00, 0.00, 1),
(40, 31, 2, 'Alineamiento y balanceo', 1, 60.00, 0.00, 0.00, 1),
(41, 32, 1, 'Mano de obra cambio de correa', 1, 150.00, 0.00, 0.00, 1),
(42, 33, 3, 'Servicio de planchado y pintura (no listado)', 1, 250.00, 0.00, 0.00, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `automoviles`
--
ALTER TABLE `automoviles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cliente_id` (`cliente_id`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ubigeo_id` (`ubigeo_id`);

--
-- Indices de la tabla `cotizaciones_estados`
--
ALTER TABLE `cotizaciones_estados`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `egresos`
--
ALTER TABLE `egresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `egresos_productos`
--
ALTER TABLE `egresos_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `egreso_id` (`egreso_id`);

--
-- Indices de la tabla `estadosordenes`
--
ALTER TABLE `estadosordenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `ingresos_productos`
--
ALTER TABLE `ingresos_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `ingreso_id` (`ingreso_id`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `pendientes`
--
ALTER TABLE `pendientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoria_id` (`categoria_id`);

--
-- Indices de la tabla `productos_proveedores`
--
ALTER TABLE `productos_proveedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `producto_id` (`producto_id`),
  ADD KEY `proveedor_id` (`proveedor_id`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ubigeo_id` (`ubigeo_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD PRIMARY KEY (`rol_id`,`permiso_id`),
  ADD KEY `permiso_id` (`permiso_id`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubigeos`
--
ALTER TABLE `ubigeos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `persona_id` (`persona_id`),
  ADD KEY `email` (`email`),
  ADD KEY `rol_id` (`rol_id`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD KEY `cliente_id` (`cliente_id`),
  ADD KEY `automovil_id` (`automovil_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `estado_id` (`estado_id`),
  ADD KEY `comprobante_usuario_id` (`comprobante_usuario_id`),
  ADD KEY `orden_usuario_id` (`orden_usuario_id`);

--
-- Indices de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_id` (`venta_id`),
  ADD KEY `producto_id` (`producto_id`);

--
-- Indices de la tabla `ventas_servicios`
--
ALTER TABLE `ventas_servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venta_id` (`venta_id`),
  ADD KEY `servicio_id` (`servicio_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `automoviles`
--
ALTER TABLE `automoviles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=486;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT de la tabla `cotizaciones_estados`
--
ALTER TABLE `cotizaciones_estados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `egresos`
--
ALTER TABLE `egresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `egresos_productos`
--
ALTER TABLE `egresos_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT de la tabla `estadosordenes`
--
ALTER TABLE `estadosordenes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `ingresos`
--
ALTER TABLE `ingresos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `ingresos_productos`
--
ALTER TABLE `ingresos_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT de la tabla `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pendientes`
--
ALTER TABLE `pendientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT de la tabla `productos_proveedores`
--
ALTER TABLE `productos_proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `ubigeos`
--
ALTER TABLE `ubigeos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=262;

--
-- AUTO_INCREMENT de la tabla `ventas_productos`
--
ALTER TABLE `ventas_productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=392;

--
-- AUTO_INCREMENT de la tabla `ventas_servicios`
--
ALTER TABLE `ventas_servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=482;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`ubigeo_id`) REFERENCES `ubigeos` (`id`);

--
-- Filtros para la tabla `rol_permiso`
--
ALTER TABLE `rol_permiso`
  ADD CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
