-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-04-2026 a las 04:32:56
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `avian`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asientos`
--

CREATE TABLE `asientos` (
  `id` int(11) NOT NULL,
  `avion_id` int(11) NOT NULL,
  `numero_asiento` varchar(5) NOT NULL,
  `clase` enum('economica','primera') NOT NULL DEFAULT 'economica',
  `estado` enum('disponible','ocupado','reservado') NOT NULL DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asientos`
--

INSERT INTO `asientos` (`id`, `avion_id`, `numero_asiento`, `clase`, `estado`) VALUES
(1, 1, '1A', 'primera', 'disponible'),
(2, 1, '1B', 'primera', 'disponible'),
(3, 1, '1C', 'primera', 'disponible'),
(4, 1, '1D', 'primera', 'disponible'),
(5, 1, '1E', 'primera', 'disponible'),
(6, 1, '1F', 'primera', 'disponible'),
(7, 1, '2A', 'primera', 'disponible'),
(8, 1, '2B', 'primera', 'disponible'),
(9, 1, '2C', 'primera', 'disponible'),
(10, 1, '2D', 'primera', 'disponible'),
(11, 1, '2E', 'primera', 'disponible'),
(12, 1, '2F', 'primera', 'disponible'),
(13, 1, '3A', 'economica', 'disponible'),
(14, 1, '3B', 'economica', 'disponible'),
(15, 1, '3C', 'economica', 'disponible'),
(16, 1, '3D', 'economica', 'disponible'),
(17, 1, '3E', 'economica', 'disponible'),
(18, 1, '3F', 'economica', 'disponible'),
(19, 1, '4A', 'economica', 'disponible'),
(20, 1, '4B', 'economica', 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aviones`
--

CREATE TABLE `aviones` (
  `id` int(11) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `aerolinea` varchar(100) NOT NULL,
  `capacidad_total` int(11) NOT NULL,
  `capacidad_primera` int(11) NOT NULL DEFAULT 0,
  `capacidad_economica` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aviones`
--

INSERT INTO `aviones` (`id`, `modelo`, `matricula`, `aerolinea`, `capacidad_total`, `capacidad_primera`, `capacidad_economica`) VALUES
(1, 'Airbus A320', 'HK-5001', 'Avianca', 150, 12, 138),
(2, 'Boeing 737', 'HK-5002', 'Latam', 160, 16, 144),
(3, 'Airbus A319', 'HK-5003', 'Avianca', 120, 8, 112),
(4, 'Boeing 787', 'HK-5004', 'Latam', 250, 30, 220);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudades`
--

CREATE TABLE `ciudades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo_iata` char(3) NOT NULL,
  `pais` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudades`
--

INSERT INTO `ciudades` (`id`, `nombre`, `codigo_iata`, `pais`) VALUES
(1, 'Barranquilla', 'BAQ', 'Colombia'),
(2, 'Bogotá', 'BOG', 'Colombia'),
(3, 'Medellín', 'MDE', 'Colombia'),
(4, 'Cartagena', 'CTG', 'Colombia'),
(5, 'Cali', 'CLO', 'Colombia'),
(6, 'Miami', 'MIA', 'Estados Unidos'),
(7, 'Ciudad de México', 'MEX', 'México'),
(8, 'Madrid', 'MAD', 'España');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `numero_factura` varchar(50) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `impuesto` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `metodo_pago` enum('tarjeta_credito','tarjeta_debito','transferencia','efectivo') NOT NULL,
  `codigo_transaccion` varchar(100) DEFAULT NULL,
  `fecha_pago` datetime NOT NULL DEFAULT current_timestamp(),
  `estado_pago` enum('pagado','pendiente','reembolsado') NOT NULL DEFAULT 'pagado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `vuelo_id` int(11) NOT NULL,
  `asiento_id` int(11) NOT NULL,
  `clase` enum('economica','primera') NOT NULL,
  `precio_pagado` decimal(10,2) NOT NULL,
  `estado` enum('activo','cancelado','usado') NOT NULL DEFAULT 'activo',
  `fecha_compra` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `email`, `password_hash`, `telefono`, `fecha_registro`) VALUES
(1, 'Gonzalo', 'Prueba', 'gonzalo@email.com', 'reemplazar_con_hash_real', '3001234567', '2026-04-04 18:58:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vuelos`
--

CREATE TABLE `vuelos` (
  `id` int(11) NOT NULL,
  `numero_vuelo` varchar(20) NOT NULL,
  `avion_id` int(11) NOT NULL,
  `ciudad_origen_id` int(11) NOT NULL,
  `ciudad_destino_id` int(11) NOT NULL,
  `fecha_salida` datetime NOT NULL,
  `fecha_llegada` datetime NOT NULL,
  `precio_economica` decimal(10,2) NOT NULL,
  `precio_primera` decimal(10,2) NOT NULL,
  `escalas` int(11) NOT NULL DEFAULT 0,
  `aerolinea` varchar(100) NOT NULL,
  `estado` enum('programado','en_vuelo','aterrizado','cancelado') NOT NULL DEFAULT 'programado'
) ;

--
-- Volcado de datos para la tabla `vuelos`
--

INSERT INTO `vuelos` (`id`, `numero_vuelo`, `avion_id`, `ciudad_origen_id`, `ciudad_destino_id`, `fecha_salida`, `fecha_llegada`, `precio_economica`, `precio_primera`, `escalas`, `aerolinea`, `estado`) VALUES
(1, 'AV101', 1, 1, 2, '2026-04-10 06:00:00', '2026-04-10 07:30:00', 250000.00, 650000.00, 0, 'Avianca', 'programado'),
(2, 'LA202', 2, 2, 3, '2026-04-10 08:00:00', '2026-04-10 09:00:00', 200000.00, 500000.00, 0, 'Latam', 'programado'),
(3, 'AV303', 1, 1, 4, '2026-04-11 10:00:00', '2026-04-11 11:10:00', 220000.00, 580000.00, 0, 'Avianca', 'programado'),
(4, 'LA404', 4, 2, 6, '2026-04-12 14:00:00', '2026-04-12 20:00:00', 850000.00, 2500000.00, 0, 'Latam', 'programado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_asiento_avion` (`avion_id`,`numero_asiento`);

--
-- Indices de la tabla `aviones`
--
ALTER TABLE `aviones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `matricula` (`matricula`);

--
-- Indices de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codigo_iata` (`codigo_iata`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_id` (`ticket_id`),
  ADD UNIQUE KEY `numero_factura` (`numero_factura`);

--
-- Indices de la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `asiento_id` (`asiento_id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `vuelo_id` (`vuelo_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `vuelos`
--
ALTER TABLE `vuelos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_vuelo` (`numero_vuelo`),
  ADD KEY `avion_id` (`avion_id`),
  ADD KEY `ciudad_origen_id` (`ciudad_origen_id`),
  ADD KEY `ciudad_destino_id` (`ciudad_destino_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asientos`
--
ALTER TABLE `asientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `aviones`
--
ALTER TABLE `aviones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ciudades`
--
ALTER TABLE `ciudades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `vuelos`
--
ALTER TABLE `vuelos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asientos`
--
ALTER TABLE `asientos`
  ADD CONSTRAINT `asientos_ibfk_1` FOREIGN KEY (`avion_id`) REFERENCES `aviones` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`);

--
-- Filtros para la tabla `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`vuelo_id`) REFERENCES `vuelos` (`id`),
  ADD CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`asiento_id`) REFERENCES `asientos` (`id`);

--
-- Filtros para la tabla `vuelos`
--
ALTER TABLE `vuelos`
  ADD CONSTRAINT `vuelos_ibfk_1` FOREIGN KEY (`avion_id`) REFERENCES `aviones` (`id`),
  ADD CONSTRAINT `vuelos_ibfk_2` FOREIGN KEY (`ciudad_origen_id`) REFERENCES `ciudades` (`id`),
  ADD CONSTRAINT `vuelos_ibfk_3` FOREIGN KEY (`ciudad_destino_id`) REFERENCES `ciudades` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
