-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Apr 29, 2025 at 02:05 PM
-- Server version: 8.0.34
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bangars_price_camparision_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `category_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`category_id`, `parent_id`, `category_name`) VALUES
(1, NULL, 'All Categories'),
(2, 1, 'Groceries'),
(3, 1, 'Cars'),
(4, 1, 'Houses'),
(5, 2, 'Vegetables'),
(6, 2, 'Fruits'),
(7, 2, 'Dairy'),
(8, 3, 'Sedan'),
(9, 3, 'SUV'),
(10, 3, 'Electric Cars'),
(11, 4, 'Apartments'),
(12, 4, 'Villas'),
(13, 4, 'Townhouses'),
(14, 5, 'Potatoes'),
(15, 5, 'Tomatoes'),
(16, 6, 'Apples'),
(17, 6, 'Bananas'),
(18, 7, 'Milk'),
(19, 7, 'Cheese'),
(20, 7, 'Yogurt'),
(21, 8, 'Luxury Sedans'),
(22, 9, 'Compact SUVs'),
(23, 10, 'Tesla Models'),
(24, 8, 'Toyota'),
(25, 8, 'Honda'),
(26, 9, 'Ford'),
(27, 9, 'Chevrolet'),
(28, 10, 'Tesla'),
(29, 10, 'Lucid'),
(30, 22, 'BMW'),
(31, 22, 'Porsche'),
(32, 11, 'New York'),
(33, 11, 'Los Angeles'),
(34, 11, 'Houston'),
(35, 12, 'Miami'),
(36, 12, 'Chicago'),
(37, 13, 'San Francisco'),
(38, 14, 'Organic Farms'),
(39, 14, 'Golden Harvest'),
(40, 15, 'Fresh Valley'),
(41, 16, 'Red Farm'),
(42, 18, 'Organic Dairy'),
(43, 19, 'Dairy Best'),
(44, 20, 'Yogurt Land');

-- --------------------------------------------------------

--
-- Table structure for table `Prices`
--

CREATE TABLE `Prices` (
  `price_id` int NOT NULL,
  `product_id` int NOT NULL,
  `store_id` int NOT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `todays_price` decimal(10,2) DEFAULT NULL,
  `discount` decimal(5,2) DEFAULT NULL,
  `last_updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Prices`
--

INSERT INTO `Prices` (`price_id`, `product_id`, `store_id`, `original_price`, `todays_price`, `discount`, `last_updated`) VALUES
(1, 1, 3, 24999.00, 22970.02, 8.12, '2025-04-25 03:26:23'),
(2, 2, 3, 26999.00, 21852.03, 19.06, '2025-04-25 03:26:23'),
(3, 3, 6, 22999.00, 19570.34, 14.91, '2025-04-25 03:26:23'),
(4, 4, 6, 24500.00, 21468.24, 12.37, '2025-04-25 03:26:23'),
(5, 5, 8, 39500.00, 37934.08, 3.96, '2025-04-25 03:26:23'),
(6, 6, 8, 44500.00, 42736.07, 3.96, '2025-04-25 03:26:23'),
(7, 7, 10, 89999.00, 88105.79, 2.10, '2025-04-25 03:26:23'),
(8, 8, 10, 114999.00, 94923.23, 17.46, '2025-04-25 03:26:23'),
(9, 9, 22, 759000.00, 664723.20, 12.42, '2025-04-25 03:26:23'),
(10, 10, 22, 789999.00, 675817.45, 14.45, '2025-04-25 03:26:23'),
(11, 11, 21, 780000.00, 74520.00, 90.45, '2025-04-25 03:28:39'),
(12, 12, 21, 825000.00, 78930.75, 90.43, '2025-04-25 03:28:39'),
(13, 13, 26, 850000.00, 80800.00, 90.49, '2025-04-25 03:28:39'),
(14, 14, 26, 920000.00, 89990.00, 90.22, '2025-04-25 03:28:39'),
(15, 15, 29, 650000.00, 61750.00, 90.50, '2025-04-25 03:28:39'),
(16, 16, 29, 690000.00, 65850.00, 90.46, '2025-04-26 05:16:30'),
(17, 17, 1, 5.49, 4.75, 13.48, '2025-04-26 05:16:30'),
(18, 18, 1, 6.29, 5.29, 15.90, '2025-04-26 05:16:30'),
(19, 19, 2, 3.99, 3.55, 11.03, '2025-04-26 05:16:30'),
(20, 20, 2, 4.39, 4.12, 6.15, '2025-04-26 05:16:30'),
(21, 21, 31, 2.99, 2.70, 9.70, '2025-04-27 05:16:30'),
(22, 22, 31, 3.59, 3.29, 8.36, '2025-04-27 05:16:30'),
(23, 23, 39, 25.00, 22.49, 10.04, '2025-04-27 05:16:30'),
(24, 24, 40, 49.99, 45.00, 9.98, '2025-04-27 05:16:30'),
(25, 25, 1, 7.00, 4.00, 42.86, '2025-04-27 05:16:30');

--
-- Triggers `Prices`
--
DELIMITER $$
CREATE TRIGGER `before_price_update` BEFORE UPDATE ON `Prices` FOR EACH ROW BEGIN
  IF NEW.todays_price != OLD.todays_price THEN
    SET NEW.discount = ROUND((NEW.original_price - NEW.todays_price) / NEW.original_price * 100, 2);
    
    INSERT INTO Price_History (price_id, old_price, new_price, changed_on)
    VALUES (OLD.price_id, OLD.todays_price, NEW.todays_price, NOW());
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Price_History`
--

CREATE TABLE `Price_History` (
  `history_id` int NOT NULL,
  `price_id` int NOT NULL,
  `old_price` decimal(10,2) NOT NULL,
  `new_price` decimal(10,2) NOT NULL,
  `changed_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Price_History`
--

INSERT INTO `Price_History` (`history_id`, `price_id`, `old_price`, `new_price`, `changed_on`) VALUES
(1, 1, 25500.00, 24999.00, '2025-03-12 21:09:44'),
(2, 2, 27500.00, 26999.00, '2025-03-12 21:09:44'),
(3, 3, 23500.00, 22999.00, '2025-03-12 21:09:44'),
(4, 4, 25000.00, 24500.00, '2025-03-12 21:09:44'),
(5, 5, 41000.00, 39500.00, '2025-03-12 21:09:44'),
(6, 6, 46000.00, 44500.00, '2025-03-12 21:09:44'),
(7, 7, 92000.00, 89999.00, '2025-03-12 21:09:44'),
(8, 8, 117000.00, 114999.00, '2025-03-12 21:09:44'),
(9, 9, 780000.00, 759000.00, '2025-03-12 21:09:44'),
(10, 10, 800000.00, 789999.00, '2025-03-12 21:09:44'),
(11, 11, 800000.00, 780000.00, '2025-03-12 21:09:44'),
(12, 12, 840000.00, 825000.00, '2025-03-12 21:09:44'),
(13, 13, 870000.00, 850000.00, '2025-03-12 21:09:44'),
(14, 14, 940000.00, 920000.00, '2025-03-12 21:09:44'),
(15, 15, 670000.00, 650000.00, '2025-03-12 21:09:44'),
(16, 16, 700000.00, 690000.00, '2025-03-12 21:09:44'),
(17, 17, 5.99, 5.49, '2025-03-12 21:09:44'),
(18, 18, 6.79, 6.29, '2025-03-12 21:09:44'),
(19, 19, 4.29, 3.99, '2025-03-12 21:09:44'),
(20, 20, 4.79, 4.39, '2025-03-12 21:09:44'),
(21, 21, 3.29, 2.99, '2025-03-12 21:09:44'),
(22, 22, 3.99, 3.59, '2025-03-12 21:09:44'),
(23, 1, 24999.00, 22970.02, '2025-04-25 03:26:23'),
(24, 2, 26999.00, 21852.03, '2025-04-25 03:26:23'),
(25, 3, 22999.00, 19570.34, '2025-04-25 03:26:23'),
(26, 4, 24500.00, 21468.24, '2025-04-25 03:26:23'),
(27, 5, 39500.00, 37934.08, '2025-04-25 03:26:23'),
(28, 6, 44500.00, 42736.07, '2025-04-25 03:26:23'),
(29, 7, 89999.00, 88105.79, '2025-04-25 03:26:23'),
(30, 8, 114999.00, 94923.23, '2025-04-25 03:26:23'),
(31, 9, 759000.00, 664723.20, '2025-04-25 03:26:23'),
(32, 10, 789999.00, 675817.45, '2025-04-25 03:26:23'),
(33, 11, 780000.00, 74520.00, '2025-04-25 03:28:39'),
(34, 12, 825000.00, 78930.75, '2025-04-25 03:28:39'),
(35, 13, 850000.00, 80800.00, '2025-04-25 03:28:39'),
(36, 14, 920000.00, 89990.00, '2025-04-25 03:28:39'),
(37, 15, 650000.00, 61750.00, '2025-04-25 03:28:39'),
(38, 16, 690000.00, 65850.00, '2025-04-25 03:28:39'),
(39, 17, 5.49, 5.20, '2025-04-25 03:28:39'),
(40, 18, 6.29, 5.29, '2025-04-25 03:28:39'),
(41, 19, 3.99, 3.55, '2025-04-25 03:28:39'),
(42, 20, 4.39, 4.12, '2025-04-25 03:28:39'),
(43, 21, 2.99, 2.70, '2025-04-25 03:28:39'),
(44, 22, 3.59, 3.29, '2025-04-25 03:28:39'),
(45, 23, 25.00, 22.49, '2025-04-25 03:28:39'),
(46, 24, 49.99, 45.00, '2025-04-25 03:28:39'),
(47, 17, 5.20, 5.00, '2025-04-25 03:47:45'),
(48, 17, 5.00, 4.75, '2025-04-25 03:59:00'),
(49, 25, 5.00, 6.00, '2025-04-25 15:21:26'),
(50, 25, 6.00, 4.00, '2025-04-25 16:36:31');

-- --------------------------------------------------------

--
-- Table structure for table `Products`
--

CREATE TABLE `Products` (
  `product_id` int NOT NULL,
  `product_parent_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `category_id` int NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Products`
--

INSERT INTO `Products` (`product_id`, `product_parent_id`, `name`, `category_id`, `description`, `created_at`) VALUES
(1, NULL, 'Toyota Camry', 24, 'Toyota Camry Midsize Sedan', '2025-03-12 20:08:43'),
(2, 1, 'Toyota Camry Hybrid', 24, 'Hybrid version with better mileage', '2025-03-12 20:08:43'),
(3, NULL, 'Honda Civic', 25, 'Honda Civic Compact Sedan', '2025-03-12 20:08:43'),
(4, 3, 'Honda Civic EX', 25, 'Honda Civic EX with sunroof and lane assist', '2025-03-12 20:08:43'),
(5, NULL, 'Ford Mustang', 26, 'Ford Mustang Classic Sports Car', '2025-03-12 20:08:43'),
(6, 5, 'Ford Mustang GT', 26, 'Ford Mustang GT 5.0L V8 high-performance model', '2025-03-12 20:08:43'),
(7, NULL, 'Tesla Model S', 28, 'Tesla Model S Long Range electric sedan', '2025-03-12 20:08:43'),
(8, 7, 'Tesla Model S Plaid', 28, 'High-performance Tesla Model S Plaid with 1020 HP', '2025-03-12 20:08:43'),
(9, NULL, 'BMW M3', 30, 'BMW M3 high-performance sports sedan', '2025-03-12 20:08:43'),
(10, 9, 'BMW M3 Competition', 30, 'BMW M3 Competition with 503 HP', '2025-03-12 20:08:43'),
(11, NULL, '3BHK Apartment', 11, 'Spacious 3-bedroom apartment', '2025-03-12 20:08:43'),
(12, 11, '3BHK Apartment - New York', 32, 'Apartment located in New York', '2025-03-12 20:08:43'),
(13, NULL, 'Luxury Villa', 12, 'Premium luxury villa with private pool', '2025-03-12 20:08:43'),
(14, 13, 'Luxury Villa - Miami', 35, 'Oceanfront villa in Miami with pool and garden', '2025-03-12 20:08:43'),
(15, NULL, 'Modern Townhouse', 13, '3-story townhouse with rooftop access', '2025-03-12 20:08:43'),
(16, 15, 'Modern Townhouse - San Francisco', 37, 'San Francisco townhouse with city view', '2025-04-26 05:16:12'),
(17, NULL, 'Yukon Gold Potatoes', 14, 'Premium golden potatoes for cooking', '2025-04-26 05:16:12'),
(18, 17, 'Organic Yukon Gold Potatoes', 38, 'Organic Farms branded Yukon Gold potatoes', '2025-04-26 05:16:12'),
(19, NULL, 'Fresh Red Apples', 16, 'Crisp and sweet red apples', '2025-04-26 05:16:12'),
(20, 19, 'Red Farm Red Apples', 41, 'Red Farm branded organic red apples', '2025-04-26 05:16:12'),
(21, NULL, 'Whole Milk', 18, 'High-quality dairy milk', '2025-04-27 05:16:12'),
(22, 21, 'Organic Dairy Whole Milk', 42, 'Organic Dairy branded whole milk', '2025-04-27 05:16:12'),
(23, NULL, 'Admin Special Item A', 14, 'Exclusive product by Admin One', '2025-04-27 05:16:12'),
(24, NULL, 'Admin Special Item B', 25, 'Product managed by Admin Two', '2025-04-27 05:16:12'),
(25, NULL, 'Peppers', 5, 'Green Peppers 1LB', '2025-04-27 05:16:12');

-- --------------------------------------------------------

--
-- Table structure for table `Stores`
--

CREATE TABLE `Stores` (
  `store_id` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Stores`
--

INSERT INTO `Stores` (`store_id`, `user_id`, `name`, `location`, `contact_info`, `created_at`, `updated_at`) VALUES
(1, 2, 'LA Grocery Mart', 'Los Angeles, CA', '123-456-7897', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(2, 2, 'Fresh Vegetables Hub', 'Los Angeles, CA', '123-555-7890', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(3, 4, 'Houston Auto Dealership', 'Houston, TX', '987-654-3210', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(4, 4, 'Luxury Homes Realty', 'Houston, TX', '567-890-1234', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(5, 6, 'Miami Organic Market', 'Miami, FL', '111-222-3333', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(6, 8, 'Austin Car Showroom', 'Austin, TX', '444-555-6666', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(7, 10, 'Boston Fresh Mart', 'Boston, MA', '777-888-9999', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(8, 12, 'Phoenix Used Cars', 'Phoenix, AZ', '888-999-0000', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(9, 14, 'San Diego Homes Realty', 'San Diego, CA', '999-000-1111', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(10, 16, 'Portland Auto World', 'Portland, OR', '222-333-4444', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(11, 18, 'D.C. Grocery Warehouse', 'Washington D.C.', '333-444-5555', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(12, 20, 'Nashville Farmers Market', 'Nashville, TN', '666-777-8888', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(13, 2, 'West LA Supermarket', 'Los Angeles, CA', '321-654-9870', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(14, 4, 'Downtown Houston Realty', 'Houston, TX', '444-111-2222', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(15, 6, 'Florida Car Traders', 'Miami, FL', '555-222-1111', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(16, 8, 'Austin Home Deals', 'Austin, TX', '111-666-3333', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(17, 10, 'Boston Auto Sales', 'Boston, MA', '777-000-5555', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(18, 12, 'Arizona Car Store', 'Phoenix, AZ', '222-555-9999', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(19, 14, 'San Diego Condo Listings', 'San Diego, CA', '999-111-4444', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(20, 16, 'Portland Grocery Hub', 'Portland, OR', '444-666-7777', '2025-03-12 16:05:41', '2025-04-24 03:12:12'),
(21, 4, 'New York Luxury Autos', 'New York, NY', '999-222-3333', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(22, 6, 'Chicago Car Hub', 'Chicago, IL', '888-777-6666', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(23, 8, 'Dallas Premium Cars', 'Dallas, TX', '777-555-4444', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(24, 10, 'San Francisco Auto Dealers', 'San Francisco, CA', '666-444-3333', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(25, 12, 'Denver Auto Sales', 'Denver, CO', '555-333-2222', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(26, 14, 'Los Angeles Home Realty', 'Los Angeles, CA', '333-888-9999', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(27, 16, 'Seattle Dream Homes', 'Seattle, WA', '222-777-8888', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(28, 18, 'Las Vegas Property Experts', 'Las Vegas, NV', '111-666-7777', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(29, 20, 'Atlanta Real Estate', 'Atlanta, GA', '999-444-1111', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(30, 2, 'Philadelphia Home Listings', 'Philadelphia, PA', '888-222-5555', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(31, 4, 'Chicago Fresh Market', 'Chicago, IL', '777-999-8888', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(32, 6, 'Dallas Farmers Market', 'Dallas, TX', '666-777-2222', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(33, 8, 'San Francisco Organic Foods', 'San Francisco, CA', '555-666-9999', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(34, 10, 'Denver Natural Grocers', 'Denver, CO', '444-555-8888', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(35, 12, 'Seattle Green Market', 'Seattle, WA', '333-444-6666', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(36, 14, 'Las Vegas Supermart', 'Las Vegas, NV', '222-333-5555', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(37, 16, 'Atlanta Farmers Hub', 'Atlanta, GA', '111-222-4444', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(38, 18, 'Philadelphia Whole Foods', 'Philadelphia, PA', '999-888-7777', '2025-03-12 20:38:43', '2025-04-24 03:12:12'),
(39, 21, 'Admin NY Store', 'New York, NY', '111-222-3333', '2025-04-22 01:58:18', '2025-04-24 03:12:12'),
(40, 22, 'Admin LA Market', 'Los Angeles, CA', '444-555-6666', '2025-04-22 01:58:18', '2025-04-24 03:12:12'),
(41, 23, 'Admin Chicago Mart', 'Chicago, IL', '777-888-9999', '2025-04-22 01:58:18', '2025-04-24 03:12:12'),
(42, 24, 'Admin Houston Plaza', 'Houston, TX', '222-333-4444', '2025-04-22 01:58:18', '2025-04-24 03:12:12'),
(43, 25, 'Admin Seattle Superstore', 'Seattle, WA', '555-666-7777', '2025-04-22 01:58:18', '2025-04-24 03:12:12'),
(45, 8, 'Walmart', 'Potsdam, NY', '3159832874', '2025-04-24 11:49:18', '2025-04-24 11:49:18');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` enum('buyer','seller','admin') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `name`, `email`, `password`, `role`, `location`, `created_at`, `updated_at`) VALUES
(1, 'Alice', 'alice@example.com', '24a7430a43b604df19ee14671387a4f7', 'buyer', 'New York', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(2, 'Bob Smith', 'bob@example.com', '53bc33742ac6cd32694390f18638958d', 'seller', 'Los Angeles', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(4, 'David Brown', 'david@example.com', '8c75389832461dc868b5bbe7e5cd0212', 'seller', 'Houston', '2025-03-12 16:05:05', '2025-04-23 21:54:43'),
(5, 'Emma', 'emma@example.com', 'a6c40ff410933ea4e59246f5c084d5dc', 'buyer', 'San Francisco', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(6, 'Frank Thomas', 'frank@example.com', 'b79388915a8b9ab4bbd7c578c961da45', 'seller', 'Miami', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(7, 'Grace Martin', 'grace@example.com', '1b6a8f58c7a319b9e9a0c59c0a499207', 'buyer', 'Seattle', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(8, 'Henry Clark', 'henry@example.com', 'fe0b579bfdf877aa7a387fbe5294f622', 'seller', 'Austin', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(9, 'Isabella White', 'isabella@example.com', '66c106118bc99f49be006a573002cb3a', 'buyer', 'Denver', '2025-03-12 16:05:05', '2025-04-23 21:54:43'),
(10, 'Jack Lewis', 'jack@example.com', 'f3a24bbe3810041ecb25b6752e070e98', 'seller', 'Boston', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(11, 'Karen Walker', 'karen@example.com', '9764610b8468fc9f4e2ac7ffda910443', 'buyer', 'Philadelphia', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(12, 'Liam Hall', 'liam@example.com', 'b06d17d7394a82a12c71e0fb5c50cd0e', 'seller', 'Phoenix', '2025-03-12 16:05:05', '2025-04-28 01:26:42'),
(13, 'Mia Young', 'mia@example.com', '4b3d5ff637bca76f6fb371035dc6ac05', 'buyer', 'Dallas', '2025-03-12 16:05:05', '2025-04-23 21:54:43'),
(14, 'Nathan King', 'nathan@example.com', 'c6ce5469727e3817d35d4ed03dbff928', 'seller', 'San Diego', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(15, 'Olivia Scott', 'olivia@example.com', 'fc802c4eca66b74ec472128ed33a2991', 'buyer', 'Las Vegas', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(16, 'Paul Green', 'paul@example.com', '23074d164b2b869497a05c1235c156de', 'seller', 'Portland', '2025-03-12 16:05:05', '2025-04-23 21:54:43'),
(17, 'Quincy Adams', 'quincy@example.com', 'ade8fb35493f556b2bc55c090afd45d0', 'buyer', 'Atlanta', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(18, 'Rachel Moore', 'rachel@example.com', 'c29c68ac164dac188ea07cf43e28b80c', 'seller', 'Washington D.C.', '2025-03-12 16:05:05', '2025-04-26 05:15:45'),
(19, 'Samuel Turner', 'samuel@example.com', 'e62a582730859e47c1031ed1303d236b', 'buyer', 'Detroit', '2025-03-12 16:05:05', '2025-04-23 21:54:43'),
(20, 'Tina Harris', 'tina@example.com', '5378c47b09275bfc9cf8c28e7e0c49ff', 'seller', 'Nashville', '2025-03-12 16:05:05', '2025-04-27 05:15:44'),
(21, 'Ethan Brooks', 'ethan@example.com', 'c340a8435ae47ae89838c2d8476d5acf', 'admin', 'New York', '2025-04-22 01:57:25', '2025-04-23 21:54:43'),
(22, 'Sophia Bennett', 'sophia@example.com', 'b31d7edddc23c55fd38c26e62c2b4b9f', 'admin', 'Los Angeles', '2025-04-22 01:57:25', '2025-04-26 05:15:45'),
(23, 'Lia Morgan', 'lia@example.com', 'hashed_liam', 'admin', 'Chicago', '2025-04-22 01:56:33', '2025-04-28 01:24:07'),
(24, 'Ava Coleman', 'ava@example.com', '1192cd480db24eacec1ff8c77c195a58', 'admin', 'Houston', '2025-04-22 01:56:33', '2025-04-23 21:54:43'),
(25, 'Noah Foster', 'noah@example.com', '09ad6ef1a5a1759a7f0718209987adfb', 'admin', 'Seattle', '2025-04-22 01:56:33', '2025-04-26 05:15:45'),
(26, 'Charlie', 'charlie@json.com', '24f92cb7452d1e318ab1b8ca53b4b200', 'buyer', 'New York', '2025-04-23 21:41:49', '2025-04-23 21:41:49');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `Prices`
--
ALTER TABLE `Prices`
  ADD PRIMARY KEY (`price_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `Price_History`
--
ALTER TABLE `Price_History`
  ADD PRIMARY KEY (`history_id`),
  ADD KEY `price_id` (`price_id`);

--
-- Indexes for table `Products`
--
ALTER TABLE `Products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `parent_id` (`product_parent_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `Stores`
--
ALTER TABLE `Stores`
  ADD PRIMARY KEY (`store_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `Prices`
--
ALTER TABLE `Prices`
  MODIFY `price_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `Price_History`
--
ALTER TABLE `Price_History`
  MODIFY `history_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `Products`
--
ALTER TABLE `Products`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `Stores`
--
ALTER TABLE `Stores`
  MODIFY `store_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Categories`
--
ALTER TABLE `Categories`
  ADD CONSTRAINT `Categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `Prices`
--
ALTER TABLE `Prices`
  ADD CONSTRAINT `Prices_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Prices_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `Stores` (`store_id`) ON DELETE CASCADE;

--
-- Constraints for table `Price_History`
--
ALTER TABLE `Price_History`
  ADD CONSTRAINT `Price_History_ibfk_1` FOREIGN KEY (`price_id`) REFERENCES `Prices` (`price_id`) ON DELETE CASCADE;

--
-- Constraints for table `Products`
--
ALTER TABLE `Products`
  ADD CONSTRAINT `Products_ibfk_1` FOREIGN KEY (`product_parent_id`) REFERENCES `Products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`category_id`) ON DELETE CASCADE;

--
-- Constraints for table `Stores`
--
ALTER TABLE `Stores`
  ADD CONSTRAINT `Stores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
