-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2026 at 04:15 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bank_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `account_type` enum('Savings','Current') DEFAULT NULL,
  `balance` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`account_id`, `customer_id`, `account_type`, `balance`) VALUES
(1, 1, 'Savings', 10000.00),
(2, 2, 'Savings', 6000.00),
(3, 6, 'Savings', 2000.00),
(4, 9, 'Savings', 2000.00);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`, `phone`, `address`) VALUES
(1, 'Khandokar Limon', 'limon.kh.oct99@gmail.com', '01715910871', 'Dhaka'),
(2, 'Jackline', 'jackline@gmail.com', '01715910655', 'Chittogong'),
(6, 'Jillur', 'jillur@gmail.com', '01715910655', 'Dhaka'),
(7, 'sazim', 'sazum@gmail.com', '01715910871', 'Dhaka'),
(8, 'Arman', 'arman@gmail.com', '01715910871', 'Uttara sector 10,Road07,House20,Dhaka,Bangladesh'),
(9, 'Arman', 'arman@gmail.com', '01715910871', 'Uttara sector 10,Road07,House20,Dhaka,Bangladesh'),
(10, 'Khandokar Limon', 'limon.kh.oct99@gmail.com', '01715910871', 'Uttara sector 10,Road07,House20,Dhaka,Bangladesh');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `loan_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `emi` decimal(12,2) DEFAULT NULL,
  `status` enum('Pending','Approved') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`loan_id`, `customer_id`, `amount`, `emi`, `status`) VALUES
(1, 6, 30000.00, 2000.00, 'Approved'),
(2, 1, 50000.00, 1000.00, 'Approved');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `txn_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `txn_type` enum('Deposit','Withdraw','Transfer') DEFAULT NULL,
  `from_account` int(11) DEFAULT NULL,
  `to_account` int(11) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `txn_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`txn_id`, `account_id`, `txn_type`, `from_account`, `to_account`, `amount`, `txn_date`) VALUES
(1, 1, 'Deposit', NULL, NULL, 2000.00, '2026-01-08 16:59:17'),
(2, 1, 'Withdraw', NULL, NULL, 1000.00, '2026-01-08 17:00:28'),
(3, 3, 'Withdraw', NULL, NULL, 1000.00, '2026-01-08 18:42:12'),
(4, 4, 'Withdraw', NULL, NULL, 49000.00, '2026-01-19 11:14:18'),
(5, 4, 'Withdraw', NULL, NULL, 49000.00, '2026-01-19 11:38:31'),
(6, 4, 'Deposit', NULL, NULL, 50000.00, '2026-01-19 22:46:55'),
(7, 1, 'Withdraw', NULL, NULL, 4000.00, '2026-01-19 22:47:57'),
(8, 2, 'Transfer', NULL, NULL, 4000.00, '2026-01-19 23:51:50'),
(9, 1, 'Transfer', NULL, NULL, 4000.00, '2026-01-19 23:51:50'),
(10, 1, 'Transfer', 1, 2, 3000.00, '2026-01-20 00:33:00'),
(11, 1, 'Deposit', NULL, NULL, 4000.00, '2026-01-20 00:33:34'),
(12, 1, 'Deposit', NULL, NULL, 5000.00, '2026-01-20 00:47:54'),
(13, 1, 'Transfer', 1, 2, 1000.00, '2026-01-20 13:30:47');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('Admin','Employee') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `role`) VALUES
(1, 'admin', '$2y$10$kL0l7JVqEjaIXuayA8ujjuNjiss1kKsEn5btYy7RqMyrK6ERLrV52', 'Admin'),
(2, 'emp', '$2y$10$W0Ursk0pSYojbugG7p.3fumbiTEcGaJ3bwniHnrcJ2yOePIbAGchS', 'Employee');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`loan_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`txn_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `account_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `loan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `txn_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
